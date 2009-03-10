Given /^I do not have a valid session on the server$/ do
  @user = Hancock::User.new(:email      => /\w+@\w+\.\w{2,3}/.gen.downcase,
                            :first_name => /\w+/.gen.capitalize,
                            :last_name  => /\w+/.gen.capitalize)
  get "/sso/logout"
end

Given /^a valid consumer and user exists$/ do
  @consumer = ::Hancock::Consumer.gen(:internal)
end

Given /^I request authentication$/ do
  get "/sso/login"
end

Given /^I request authentication returning to a consumer app$/ do
  get "/sso/login?return_to=#{@consumer.url}"
end

Then /^I should see the login form$/ do
  last_response.should be_a_login_form
end

Given /^I click signup$/ do
  get "/sso/signup"
end

Then /^I should see the signup form$/ do
  last_response.should be_a_signup_form
end

Given /^I signup with valid info$/ do
  post "/sso/signup", 'email'      => @user.email,
                      'first_name' => @user.first_name,
                      'last_name'  => @user.last_name
  last_response.status.should eql(200)
end

Then /^I should receive a registration url$/ do
  @confirmation_url = last_response.body.to_s.match(%r!/sso/register/\w{40}!).to_s
  @confirmation_url.should_not match(/^\s*$/)
end

Given /^I hit the registration url and provide a password$/ do
  get @confirmation_url
  post @confirmation_url, 'user[password]' => @user.password,
                          'used[password_confirmation]' => @user.password
end

Then /^I should be redirected to the application root$/ do
  last_response.headers['Location'].should eql('/')
end

Then /^I should be redirected to the consumer app$/ do
  last_response.headers['Location'].should eql(@consumer.url)
end
