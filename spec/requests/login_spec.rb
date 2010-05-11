require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "posting to /sso/login" do
  before(:each) do
    @user = Hancock::User.gen
    @consumer = Hancock::Consumer.gen(:internal)
  end
  describe "with a valid password" do
    it "should authenticate a user and redirect to /" do
      post '/sso/login', :email => @user.email, :password => @user.password
      last_response.status.should eql(302)
      last_response.headers['Location'].should eql('/')
    end
  end
  describe "with an invalid password" do
    it "should display a form to login" do
      post '/sso/login', :email => @user.email, :password => 's3cr3t'
      last_response.body.should be_a_login_form
    end
  end
end
describe "getting /sso/login" do
  before(:each) do
    @user = Hancock::User.gen
    @consumer = Hancock::Consumer.gen(:internal)
  end

  describe "with a valid session" do
    describe "from an invalid consumer" do
      it "should return forbidden" do
        get '/sso/login'
        login(@user)

        get '/sso/login'
        last_response['Location'].should eql('/')
      end
    end
  end

  describe "without a valid session" do
    it "should prompt the user to login" do
      get '/sso/login', { 'return_to' => @consumer.url }
      last_response.body.should be_a_login_form
    end
  end
end
