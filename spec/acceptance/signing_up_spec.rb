require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /sso/signup" do
  def app
    Hancock::App
  end
  before(:each) do
    @user = Hancock::User.new(:email      => /\w+@\w+\.\w{2,3}/.gen.downcase,
                              :first_name => /\w+/.gen.capitalize,
                              :last_name  => /\w+/.gen.capitalize)
  end
  describe "when signing up" do
    it "should sign the user up" do
      get '/sso/signup'

      post '/sso/signup', :email => @user.email,
                          :first_name => @user.first_name,
                          :last_name => @user.last_name

      confirmation_url = last_response.body.to_s.match(%r!/sso/register/\w{40}!)
      confirmation_url.should_not be_nil

      get "#{confirmation_url}"
      password = /\w+{9,32}/.gen

      last_response.body.to_s.should have_selector("form[action='#{confirmation_url}']")

      post "#{confirmation_url}", :password => password, :password_confirmation => password
      follow_redirect!

      last_response.body.to_s.should have_selector("h3:contains('Hello #{@user.first_name} #{@user.last_name}')")
    end

    describe "and form hacking" do
      it "should be unauthorized" do
        get '/sso/signup'

        post '/sso/signup', :email => @user.email,
                            :first_name => @user.first_name,
                            :last_name => @user.last_name

        fake_url = /\w+{9,40}/.gen
        get "/sso/register/#{fake_url}"
        last_response.body.to_s.should match(/BadRequest/)
      end
    end
  end

  if ENV['WATIR']
    begin
      require 'safariwatir'
      describe "with no valid browser sessions" do
        before(:each) do
          @sso_server = 'http://moi.atmos.org/sso'
          @browser = Watir::Safari.new
          @browser.goto("http://localhost:5000/sso/logout")
        end
        it "should browse properly in safari" do
          # session cookie fails on localhost :\
          # sso_server = 'http://localhost:20000/sso'

          @browser.goto('http://localhost:5000/')
          @browser.link(:url, "#{@sso_server}/signup").click
          @browser.text_field(:name, :first_name).set(@user.first_name)
          @browser.text_field(:name, :last_name).set(@user.last_name)
          @browser.text_field(:name, :email).set(@user.email)
          @browser.button(:value, 'Signup').click

          register_url = @browser.html.match(%r!#{@sso_server}/register/\w{40}!).to_s
          register_url.should_not be_nil
          password = /\w+{9,32}/.gen

          @browser.goto(register_url)
          @browser.text_field(:name, :password).set(password)
          @browser.text_field(:name, :password_confirmation).set(password)
          @browser.button(:value, 'Am I Done Yet?').click

          @browser.html.should match(%r!Hancock Client: Sinatra!)
        end
      end
    rescue; end
  end
end
