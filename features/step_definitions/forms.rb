Given \
  /^I signup with valid info$/ do
  fill_in :email,      :with => @user.email
  fill_in :first_name, :with => @user.first_name
  fill_in :last_name,  :with => @user.last_name

  click_button 'Signup'
end

Given \
  /^I hit the registration url and provide a password$/ do
  visit @confirmation_url

  fill_in :password,               :with => @user.password
  fill_in :password_confirmation,  :with => @user.password

  click_button 'Am I Done Yet?'
end

Then \
  /^I login$/ do
  fill_in :email,    :with => @user.email
  fill_in :password, :with => @user.password

  click_button 'Login'
end
