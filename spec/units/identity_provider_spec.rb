require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "Requesting the server xrds" do
  describe "when accepting xrds+xml" do
    it "renders the provider idp page" do
      get '/sso/xrds'
      @response.headers['Content-Type'].should eql('application/xrds+xml')
      @response.should have_xpath("//xrd/service[uri='http://example.org/sso']")
      @response.should have_xpath("//xrd/service[type='http://specs.openid.net/auth/2.0/server']")
    end
  end
end
