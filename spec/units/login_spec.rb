require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "posting to /sso/login" do
  before(:each) do
    @user = Hancock::User.gen
    @consumer = Hancock::Consumer.gen(:internal)
  end
  describe "with a valid password" do
    it "should authenticate a user and redirect to /" do
      post '/sso/login', :email => @user.email, :password => @user.password
      @response.status.should eql(302)
      @response.headers['Location'].should eql('/')
    end
  end
  describe "with an invalid password" do
    it "should display a form to login" do
      post '/sso/login', :email => @user.email, :password => 's3cr3t'
      @response.body.should be_a_login_form
    end
  end
end
