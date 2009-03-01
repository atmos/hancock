require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /users/logout" do
  before(:each) do
    @user = Hancock::User.gen
    @consumer = Hancock::Consumer.gen(:internal)
  end
  describe "when authenticated" do
    it "should clear the session and redirec to /" do
      get '/users/logout'
      @response.status.should eql(302)
      @response.headers['Location'].should eql('/')
    end
  end
  describe "when unauthenticated" do
    it "should redirect to /" do
      get '/users/logout'
      @response.status.should eql(302)
      @response.headers['Location'].should eql('/')
    end
  end
end
