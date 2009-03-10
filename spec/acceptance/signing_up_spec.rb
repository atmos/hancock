require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /sso/signup" do
  def app
    @app = Rack::Builder.new do
      run Hancock::App
    end
  end
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
      describe "with no valid browser sessions" do
        before(:each) do
          @browser = Watir::Safari.new
          @browser.goto("http://localhost:5000/sso/logout")
        end
        it "should browse properly in safari" do
          # session cookie fail :\
          # sso_server = 'http://localhost:20000/sso'
          sso_server = 'http://moi.atmos.org/sso'

          @browser.goto('http://localhost:5000/')
#          @browser.goto("#{sso_server}/login?return_to=http://localhost:5000/sso/login")
          @browser.link(:url, "#{sso_server}/signup").click
          @browser.text_field(:name, :first_name).set(@user.first_name)
          @browser.text_field(:name, :last_name).set(@user.last_name)
          @browser.text_field(:name, :email).set(@user.email)
          @browser.button(:value, 'Signup').click

          register_url = @browser.html.match(%r!#{sso_server}/register/\w{40}!).to_s
          register_url.should_not be_nil
          password = /\w+{9,32}/.gen

          @browser.goto(register_url)
          @browser.text_field(:name, :password).set(password)
          @browser.text_field(:name, :password_confirmation).set(password)
          @browser.button(:value, 'Am I Done Yet?').click

#          @browser.goto('http://localhost:5000')
#          @browser.html.should match(%r!#{@user.first_name} #{@user.last_name}!)
        end
      end
    rescue; end
  end
end
