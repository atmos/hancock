require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe Hancock::Consumer do
  describe "internal" do
    before(:each) do
      @consumer = Hancock::Consumer.gen(:internal)
    end
    it "should save successfully" do
      @consumer.save.should be_true
    end
  end
  describe "visible to all" do
    before(:each) do
      @consumer = Hancock::Consumer.gen(:visible_to_all)
    end
    it "should save successfully" do
      @consumer.save.should be_true
    end
  end
  describe "hidden (API) apps" do
    before(:each) do
      @consumer = Hancock::Consumer.gen(:hidden)
    end
    it "should save successfully" do
      @consumer.save.should be_true
    end
  end
end
