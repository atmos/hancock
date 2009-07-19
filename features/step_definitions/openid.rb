When \
  /^I request the sso page with a checkid mode of checkIDSetup$/ do
  params = {
    "openid.ns"         => "http://specs.openid.net/auth/2.0",
    "openid.mode"       => "checkid_setup",
    "openid.return_to"  => @consumer.url,
  }
  visit "/sso", :get, params
end

When \
  /^I request the sso page with a checkid mode of associate$/ do
  @openid_session = OpenID::Consumer::AssociationManager.create_session("DH-SHA1")
  params =  {
    "openid.ns"           => 'http://specs.openid.net/auth/2.0',
    "openid.mode"         => "associate",
    "openid.session_type" => 'DH-SHA1',
    "openid.assoc_type"   => 'HMAC-SHA1',
    "openid.dh_consumer_public"=> @openid_session.get_request['dh_consumer_public']
  }
  visit "/sso", :get, params
end

When \
  /^I request the sso page with a checkid mode of immediate$/ do
  params = {
    "openid.ns"         => "http://specs.openid.net/auth/2.0",
    "openid.mode"       => "checkid_immediate",
    "openid.return_to"  => @consumer.url
  }
  visit "/sso", :get, params
end
