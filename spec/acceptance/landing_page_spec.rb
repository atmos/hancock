require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /" do
  before(:each) do
    @user = Hancock::User.gen
    @consumer = Hancock::Consumer.gen(:internal)
  end
  describe "when authenticated" do
    it "should greet the user" do
      get '/', {}, :session => {:user_id => @user.id}
      @response.body.should match(/Hello #{@user.email}/)
    end
  end
  describe "when unauthenticated" do
    it "should greet the user" do
      get '/'
      @response.body.should match(/Hello/)
    end
  end
end
