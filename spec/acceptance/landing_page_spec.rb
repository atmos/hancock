require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /" do
  before(:each) do
    @user = Hancock::User.gen
  end
  describe "when authenticated" do
    it "should greet the user" do
      get '/', {}, :session => {:user_id => @user.id}
      @response.body.should match(/Hello #{@user.email}/)
    end
  end
  describe "when unauthenticated" do
    it "should prompt the user to login" do
      get '/'
      @response.status.should eql(401)
      @response.should have_selector("form[action='/users/login'][method='POST']")
      @response.should have_selector("form[action='/users/login'][method='POST'] input[type='text'][name='email']")
      @response.should have_selector("form[action='/users/login'][method='POST'] input[type='password'][name='password']")
      @response.should have_selector("form[action='/users/login'][method='POST'] input[type='submit'][value='Login']")
    end
  end
end
