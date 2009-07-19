When \
  /^I request the login page$/ do
  visit '/sso/login'
end

When \
  /^I request the landing page$/ do
  visit '/'
end

When \
  /^I request authentication returning to the consumer app$/ do
  params = {
    "openid.ns"         => "http://specs.openid.net/auth/2.0",
    "openid.mode"       => "checkid_setup",
    "openid.return_to"  => @consumer.url
  }
  visit "/sso", :get, params
end

When \
  /^I click signup$/ do
  visit "/sso/signup"
end
