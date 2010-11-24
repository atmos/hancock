require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

class MyUserClass
  def self.authenticated?(username, password)
    username == 'atmos' && password == 'hancock'
  end
end

describe "visiting /" do
  before(:all) do
    Hancock::User.authentication_class = MyUserClass
  end

  describe "when authenticated" do
    it "should greet the user" do
      login('atmos', 'hancock')
      get '/'

      last_response.should have_selector("h2:contains('Hello \"atmos\"')")
    end
  end

  describe "when unauthenticated" do
    it "should prompt the user to login" do
      get '/'
      last_response.should be_a_login_form
    end
  end
end
