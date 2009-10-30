Then \
  /^I should be prompted to login$/ do
  last_response.should be_a_login_form
end

Then \
  /^I am redirected to the consumer app$/ do
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
  /^I am greeted$/ do
  last_response.should have_selector("h3:contains('Hello #{@user.full_name}')")
end
