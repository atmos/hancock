Then \
  /^I should be prompted to login$/ do
  last_response.should be_a_login_form
end

Then \
  /^I should see the signup form$/ do
  last_response.should be_a_signup_form
end

Then \
  /^I should be redirected to the consumer app$/ do
  last_response.headers['Location'].should eql(@consumer.url)
end

Then \
  /^I should receive a registration url via email$/ do
  @confirmation_url = last_response.body.to_s.match(%r!/sso/register/\w{40}!).to_s
  @confirmation_url.should_not match(/^\s*$/)
end

Then \
  /^I should be redirected to the consumer app to start the handshake$/ do
  redirection = Addressable::URI.parse(last_response.headers['Location'])

  "#{redirection.scheme}://#{redirection.host}#{redirection.path}".should eql(@consumer.url)
end

Then \
  /^I should see a list of consumers$/ do
  last_response.should have_selector("h3:contains('#{@user.first_name} #{@user.last_name}')")
end

Then \
  /^I should be redirected to the consumer app with openid params$/ do
  last_response.should be_a_redirect_to_the_consumer(@consumer, @user)
end

Then \
  /^I should receive an associate response from the sso server$/ do
  last_response.should be_an_openid_associate_response(@openid_session)
end

Then \
  /^I should not be redirected to the consumer app with openid params$/ do
  last_response.status.should eql(403)
end
