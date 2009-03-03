require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /sso/signup" do
  before(:each) do
    @user = Hancock::User.new(:email      => /\w+@\w+\.\w{2,3}/.gen.downcase,
                              :first_name => /\w+/.gen.capitalize,
                              :last_name  => /\w+/.gen.capitalize)
  end
  describe "when signing up" do
    it "should sign the user up" do
      visit '/sso/signup'

      fill_in 'email',      @user.email
      fill_in 'first_name', @user.first_name
      fill_in 'last_name',  @user.last_name
      click_button

      confirmation_url = response_body.match(%r!/sso/register/\w{40}!)
      confirmation_url.should_not be_nil
      visit "#{confirmation_url}"
      password = /\w+{9,32}/.gen

      response_body.should have_selector("form[action='#{confirmation_url}']")
      fill_in 'password',              password
      fill_in 'password_confirmation', password
      click_button

      puts response_body
    end
    describe "and form hacking" do
      it "should be unauthorized" do
        pending
        visit '/sso/signup'

        fill_in 'email',      @user.email
        fill_in 'first_name', @user.first_name
        fill_in 'last_name',  @user.last_name
        click_button

        visit '-1'

        puts response_body
      end
    end
  end
end
