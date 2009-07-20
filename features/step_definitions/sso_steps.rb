When \
  /^I am logged in on the sso provider$/ do
  @identity_url = "http://example.org/sso/users/#{@user.id}"

  When "I request the landing page"
  Then "I should be prompted to login"
  Then "I login"
end

When /^I signup for an account$/ do
  When "I click signup"
  Then "I should see the signup form"
  When "I signup with valid info"
  Then "I should receive a registration url via email"
  When "I hit the registration url and provide a password"
end

