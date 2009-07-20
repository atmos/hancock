When \
  /^I am logged in on the sso provider$/ do
  @identity_url = "http://example.org/sso/users/#{@user.id}"

  When "I request the landing page"
  Then "I should be prompted to login"
  Then "I login"
end
