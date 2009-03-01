require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /" do
  before(:each) do
    @user = Hancock::User.gen
    @consumer = Hancock::Consumer.gen(:internal)
    @app = Rack::Builder.new {
      run Hancock::App
    }
  end
  describe "when authenticated" do
    it "should greet the user" do
      get '/', {:foo => :bar }, :session => {:user_id => @user.id}
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
