Given /^a valid consumer and user exists$/ do
  @consumer = ::Hancock::Consumer.gen(:internal)
  @user     = ::Hancock::User.gen
  get '/sso/logout'  # log us out if we're logged in
end

Then /^I login$/ do
  post "/sso/login", :email => @user.email,
                     :password => @user.password
end

Then /^I should be redirected to the consumer app to start the handshake$/ do
  redirection = Addressable::URI.parse(last_response.headers['Location'])

  "#{redirection.scheme}://#{redirection.host}#{redirection.path}".should eql(@consumer.url)
  redirection.query_values['id'].to_i.should eql(@user.id)
end

Then /^I should be redirected to the sso provider root on login$/ do
  last_response.headers['Location'].should eql('/')
end

When /^I request the landing page$/ do
  get '/'
end

Then /^I should see a list of consumers$/ do
  last_response.headers['Location'].should eql('/')
end

When /^I request the login page$/ do
  get '/sso/login'
  pp last_response
end
