Given /^a valid consumer and user exists$/ do
  @consumer = ::Hancock::Consumer.gen(:internal)
  @user     = ::Hancock::User.gen
  visit '/sso/logout'  # log us out if we're logged in
end

Then /^I login$/ do
  fill_in :email,    :with => @user.email
  fill_in :password, :with => @user.password

  click_button 'Login'
end

Then /^I should be redirected to the consumer app to start the handshake$/ do
  redirection = Addressable::URI.parse(last_response.headers['Location'])

  "#{redirection.scheme}://#{redirection.host}#{redirection.path}".should eql(@consumer.url)
  redirection.query_values['id'].to_i.should eql(@user.id)
end

When /^I request the landing page$/ do
  visit '/'
end

Then /^I should see a list of consumers$/ do
  last_response.should have_selector("h3:contains('#{@user.first_name} #{@user.last_name}')")
end

When /^I request the login page$/ do
  visit '/sso/login'
end
