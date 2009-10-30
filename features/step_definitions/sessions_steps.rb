Given \
  /^a valid consumer and user exists$/ do
  @consumer = ::Hancock::Consumer.gen(:internal)
  @user     = ::Hancock::User.gen
end
