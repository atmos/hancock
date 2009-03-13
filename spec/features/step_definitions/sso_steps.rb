When /^I am logged in on the sso provider$/ do
  @identity_url = "http://example.org/sso/users/#{@user.id}"
  post "/sso/login", :email => @user.email,
                     :password => @user.password
end

When /^I request the sso page with a checkid mode of associate$/ do
  @openid_session = OpenID::Consumer::AssociationManager.create_session("DH-SHA1")
  params =  {"openid.ns"           => 'http://specs.openid.net/auth/2.0',
             "openid.mode"         => "associate",
             "openid.session_type" => 'DH-SHA1',
             "openid.assoc_type"   => 'HMAC-SHA1',
             "openid.dh_consumer_public"=> @openid_session.get_request['dh_consumer_public']}

  get "/sso", params
end

When /^I request the sso page with a checkid mode of immediate$/ do
  params = {
    "openid.ns"         => "http://specs.openid.net/auth/2.0",
    "openid.mode"       => "checkid_immediate",
    "openid.return_to"  => @consumer.url,
    "openid.identity"   => @identity_url,
    "openid.claimed_id" => @identity_url }

  get "/sso", params
end

Then /^I should be redirected to the consumer app with openid params$/ do
  last_response.status.should == 302

  redirect_params = Addressable::URI.parse(last_response.headers['Location']).query_values

  redirect_params['openid.ns'].should               == 'http://specs.openid.net/auth/2.0'
  redirect_params['openid.mode'].should             == 'id_res'
  redirect_params['openid.return_to'].should        == @consumer.url
  redirect_params['openid.assoc_handle'].should     =~ /^\{HMAC-SHA1\}\{[^\}]{8}\}\{[^\}]{8}\}$/
  redirect_params['openid.op_endpoint'].should      == 'http://example.org/sso' 
  redirect_params['openid.claimed_id'].should       == @identity_url
  redirect_params['openid.identity'].should         == @identity_url

  redirect_params['openid.sreg.email'].should         == @user.email
  redirect_params['openid.sreg.last_name'].should     == @user.last_name
  redirect_params['openid.sreg.first_name'].should    == @user.first_name

  redirect_params['openid.sig'].should_not be_nil
  redirect_params['openid.signed'].should_not be_nil
  redirect_params['openid.response_nonce'].should_not be_nil
end

Then /^I should receive an associate response from the sso server$/ do
  last_response.status.should == 200

  message = OpenID::Message.from_kvform("#{last_response.body}")  # wtf do i have to interpolate this!
  secret = @openid_session.extract_secret(message)
  secret.should_not be_nil

  args = message.get_args(OpenID::OPENID_NS)

  args['assoc_type'].should       == 'HMAC-SHA1'
  args['assoc_handle'].should     =~ /^\{HMAC-SHA1\}\{[^\}]{8}\}\{[^\}]{8}\}$/
  args['session_type'].should     == 'DH-SHA1'
  args['enc_mac_key'].size.should == 28
  args['expires_in'].should       =~ /^\d+$/
  args['dh_server_public'].size.should == 172
end
