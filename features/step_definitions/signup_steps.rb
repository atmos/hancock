Given /^I am not logged in on the sso provider$/ do
  @user = Hancock::User.new(:email      => /\w+@\w+\.\w{2,3}/.gen.downcase,
                            :first_name => /\w+/.gen.capitalize,
                            :last_name  => /\w+/.gen.capitalize)
end

Given /^a valid consumer exists$/ do
  @consumer = ::Hancock::Consumer.gen(:internal)
end
