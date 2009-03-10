Given /^a valid consumer and user exists$/ do
  @consumer = ::Hancock::Consumer.gen(:internal)
  @user     = ::Hancock::User.gen
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
  last_response.headers['Location'].should eql('/sso/login')
  follow_redirect!
end
