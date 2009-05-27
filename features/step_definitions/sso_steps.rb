When /^I am logged in on the sso provider$/ do
  @identity_url = "http://example.org/sso/users/#{@user.id}"
  post "/sso/login", :email => @user.email,
                     :password => @user.password
end

When /^I request the sso page with a checkid mode of checkIDSetup$/ do
  params = {
    "openid.ns"         => "http://specs.openid.net/auth/2.0",
    "openid.mode"       => "checkid_setup",
    "openid.return_to"  => @consumer.url,
    "openid.identity"   => @identity_url,
    "openid.claimed_id" => @identity_url
  }

  get "/sso", params
end
When %r!^I request the sso page with a checkid mode of checkIDSetup for another users's page$! do
  params = {
    "openid.ns"         => "http://specs.openid.net/auth/2.0",
    "openid.mode"       => "checkid_setup",
    "openid.return_to"  => @consumer.url,
    "openid.identity"   => 'http://example.org/sso/users/42',
    "openid.claimed_id" => 'http://example.org/sso/users/42'
  }

  get "/sso", params
end

When /^I request the sso page with a checkid mode of associate$/ do
  @openid_session = OpenID::Consumer::AssociationManager.create_session("DH-SHA1")
  params =  {
    "openid.ns"           => 'http://specs.openid.net/auth/2.0',
    "openid.mode"         => "associate",
    "openid.session_type" => 'DH-SHA1',
    "openid.assoc_type"   => 'HMAC-SHA1',
    "openid.dh_consumer_public"=> @openid_session.get_request['dh_consumer_public']
  }

  get "/sso", params
end

When /^I request the sso page with a checkid mode of immediate$/ do
  params = {
    "openid.ns"         => "http://specs.openid.net/auth/2.0",
    "openid.mode"       => "checkid_immediate",
    "openid.return_to"  => @consumer.url,
    "openid.identity"   => @identity_url,
    "openid.claimed_id" => @identity_url 
  }

  get "/sso", params
end

Then /^I should be redirected to the consumer app with openid params$/ do
  last_response.should be_a_redirect_to_the_consumer(@consumer, @user)
end

Then /^I should receive an associate response from the sso server$/ do
  last_response.should be_an_openid_associate_response(@openid_session)
end

Then /^I should not be redirected to the consumer app with openid params$/ do
  last_response.status.should eql(403)
end

When /^I request the OpenID Identity Provider Page$/ do
  get '/sso/xrds'
end

Then /^I should receive a yadis document from the sso server$/ do
  last_response.should be_an_identity_provider
end

