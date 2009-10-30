require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe Hancock::App do
  describe "default sreg parameters" do
    it "returns sane defaults" do
      Hancock::App.sreg_params.should eql([:id, :email, :first_name, :last_name, :internal, :admin])
    end
  end
  describe "setting the default sreg parameters" do
    it "returns the values set by the method" do
      Hancock::App.sreg_params = [:email, :birthdate, :gender]
      Hancock::App.sreg_params.should eql([:email, :birthdate, :gender])
    end
  end
end
