require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /sso/signup" do
  before(:each) do
    @user = Hancock::User.new(:email      => /\w+@\w+\.\w{2,3}/.gen.downcase,
                              :first_name => /\w+/.gen.capitalize,
                              :last_name  => /\w+/.gen.capitalize)
  end
  describe "when signing up" do
    it "should sign the user up" do
      pending
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
    end

    describe "and form hacking" do
      it "should be unauthorized" do
        pending
        visit '/sso/signup'

        fill_in 'email',      @user.email
        fill_in 'first_name', @user.first_name
        fill_in 'last_name',  @user.last_name
        click_button

        fake_url = /\w+{9,40}/.gen
        visit "/sso/register/#{fake_url}"
        response_body.should match(/BadRequest/)
      end
    end
  end

  if ENV['WATIR']
    begin
      require 'safariwatir'
      it "should browse properly in safari" do
  #      sso_server = 'http://localhost:20000/sso'
        sso_server = 'http://moi.atmos.org/sso'

        browser = Watir::Safari.new
        browser.goto("http://localhost:5000/sso/logout")
        browser.goto("#{sso_server}/logout")

        browser.goto("#{sso_server}/signup")
        browser.text_field(:name, :email).set(@user.email)
        browser.text_field(:name, :first_name).set(@user.first_name)
        browser.text_field(:name, :last_name).set(@user.last_name)
        browser.button(:value, 'Signup').click

        register_url = browser.html.match(%r!#{sso_server}/register/\w{40}!).to_s
        password = /\w+{9,32}/.gen

        browser.goto(register_url)
        browser.text_field(:name, :password).set(password)
        browser.text_field(:name, :password_confirmation).set(password)
        browser.button(:value, 'Am I Done Yet?').click

        browser.goto('http://localhost:5000')
        browser.html.should match(%r!#{@user.first_name} #{@user.last_name} - #{@user.email}!)
        puts browser.html
      end
    rescue; end
  end
end
