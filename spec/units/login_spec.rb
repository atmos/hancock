require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "posting to /users/login" do
  before(:each) do
    @user = Hancock::User.gen
    @consumer = Hancock::Consumer.gen(:internal)
  end
  describe "with a valid password" do
    it "should authenticate a user and redirect to /" do
      post '/users/login', :email => @user.email, :password => @user.password
      @response.status.should eql(302)
      @response.headers['Location'].should eql('/')
    end
  end
  describe "with an invalid password" do
    it "should display a form to login" do
      post '/users/login', :email => @user.email, :password => 's3cr3t'
      @response.status.should eql(401)
      @response.should have_selector("form[action='/users/login'][method='POST']")
      @response.should have_selector("form[action='/users/login'][method='POST'] input[type='text'][name='email']")
      @response.should have_selector("form[action='/users/login'][method='POST'] input[type='password'][name='password']")
      @response.should have_selector("form[action='/users/login'][method='POST'] input[type='submit'][value='Login']")
    end
  end
end
