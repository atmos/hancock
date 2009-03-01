require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe Hancock::Consumer do
  describe "when queried about a disallowed host" do
    it "returns false" do
      Hancock::Consumer.allowed?('http://blogspot.com').should be_false
    end
  end

  describe "visible to staff" do
    before(:each) do
      @consumer = Hancock::Consumer.gen(:internal)
      @consumer.save
    end
    describe "when queried about an allowed host" do
      it "returns true" do
        Hancock::Consumer.allowed?(@consumer.url).should be_true
      end
    end
  end
  describe "visible to customers and staff" do
    before(:each) do
      @consumer = Hancock::Consumer.gen(:visible_to_all)
      @consumer.save
    end
    describe "when queried about an allowed host" do
      it "returns true" do
        Hancock::Consumer.allowed?(@consumer.url).should be_true
      end
    end
  end
  describe "hidden (API) apps" do
    before(:each) do
      @consumer = Hancock::Consumer.gen(:hidden)
      @consumer.save
    end
    describe "when queried about an allowed host" do
      it "returns true" do
        Hancock::Consumer.allowed?(@consumer.url).should be_true
      end
    end
  end
end
