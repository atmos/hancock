require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "posting to /sso/signup" do
  before(:each) do
    @existing_user = Hancock::User.gen
    @user = Hancock::User.new(:email      => /\w+@\w+\.\w{2,3}/.gen.downcase,
                              :first_name => /\w+/.gen.capitalize,
                              :last_name  => /\w+/.gen.capitalize)
    @consumer = Hancock::Consumer.gen(:internal)
  end
  describe "with valid information" do
    it "should sign the user up" do
      post '/sso/signup', :email      => @user.email,
                          :first_name => @user.first_name,
                          :last_name  => @user.last_name

      last_response.body.to_s.should have_selector("h3:contains('Success')")
      last_response.body.to_s.should have_selector('p:contains("Check your email and you\'ll see a registration link!")')
      last_response.body.to_s.should match(%r!href='http://example.org/sso/register/\w{40}'!)
      Sinatra::Mailer::Email.should have(1).deliveries
    end
  end
  describe "with invalid information" do
    it "should not sign the user up" do
      post '/sso/signup', :email      => @existing_user.email,
                          :first_name => @existing_user.first_name,
                          :last_name  => @existing_user.last_name
      last_response.should have_selector("h3:contains('Signup Failed')")
      last_response.should have_selector("p a[href='/sso/signup']:contains('Try Again?')")
      Sinatra::Mailer::Email.should have(0).deliveries
    end
  end
end
