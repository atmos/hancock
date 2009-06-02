Given /^I am not logged in on the sso provider$/ do
  @user = Hancock::User.new(:email      => /\w+@\w+\.\w{2,3}/.gen.downcase,
                            :first_name => /\w+/.gen.capitalize,
                            :last_name  => /\w+/.gen.capitalize)
end

Given /^a valid consumer exists$/ do
  @consumer = ::Hancock::Consumer.gen(:internal)
end

Given /^I request authentication$/ do
  visit "/sso/login"
end

Given /^I request authentication returning to the consumer app$/ do
  visit "/sso/login?return_to=#{@consumer.url}"
end

Then /^I should see the login form$/ do
  last_response.should be_a_login_form
end

Given /^I click signup$/ do
  visit "/sso/signup"
end

Then /^I should see the signup form$/ do
  last_response.should be_a_signup_form
end

Given /^I signup with valid info$/ do
  fill_in :email,      :with => @user.email
  fill_in :first_name, :with => @user.first_name
  fill_in :last_name,  :with => @user.last_name

  click_button 'Signup'
end

Then /^I should receive a registration url via email$/ do
  @confirmation_url = last_response.body.to_s.match(%r!/sso/register/\w{40}!).to_s
  @confirmation_url.should_not match(/^\s*$/)
end

Given /^I hit the registration url and provide a password$/ do
  visit @confirmation_url

  fill_in :password,               :with => @user.password
  fill_in :password_confirmation,  :with => @user.password

  click_button 'Am I Done Yet?'
end

Then /^I should be redirected to the consumer app$/ do
  last_response.headers['Location'].should eql(@consumer.url)
end
