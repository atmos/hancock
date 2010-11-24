require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe Hancock::User do
  describe "with an authentication class set" do
    before(:all) do
      Hancock::User.authentication_class = MyUserClass
    end

    it "authenticates with good credentials" do
      Hancock::User.authenticated?('atmos', 'hancock').should be_true
    end

    it "does not authenticate bad credentials" do
      Hancock::User.authenticated?('atmos', 'xxxxxxx').should be_false
    end
  end
  describe "without an authentication class set" do
    before(:each) do
      Hancock::User.authentication_class = Hancock::AuthenticationUser
    end
    it "raises and error trying to authenticate" do
      lambda {
        Hancock::User.authenticated?('atmos', 'hancock')
      }.should raise_error
    end
  end
end
