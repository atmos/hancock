Then \
  /^I login$/ do
  fill_in :email,    :with => @user.email
  fill_in :password, :with => @user.password

  click_button 'Login'
end

Then \
  /^I can login as the new user$/ do
  Then "I login"
  Then "I am greeted"
end
