require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe Hancock::User do
  before(:each) do
    @user = Hancock::User.gen
  end
  it "should have specs" do 
    @user.save.should be_true
  end
end
