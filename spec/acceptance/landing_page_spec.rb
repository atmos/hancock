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
      visit '/'
      response_body.should be_a_login_form
    end
  end
end
