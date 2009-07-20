Given \
  /^I am a new user to the SSO provider$/ do
  @user = Hancock::User.new(:email                 => /\w+@\w+\.\w{2,3}/.gen.downcase,
                            :first_name            => /\w+/.gen.capitalize,
                            :last_name             => /\w+/.gen.capitalize,
                            :password              => /\w{5,9}/.gen)
end

Given \
  /^a valid consumer exists$/ do
  @consumer = ::Hancock::Consumer.gen(:internal)
end
