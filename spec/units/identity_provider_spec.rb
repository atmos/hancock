require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "Requesting the server's xrds" do
  describe "when accepting xrds+xml" do
    it "renders the provider idp page" do
      get '/sso/xrds'
      last_response.headers['Content-Type'].should eql('application/xrds+xml')
      last_response.should have_xpath("//xrd/service[uri='http://example.org/sso']")
      last_response.should have_xpath("//xrd/service[type='http://specs.openid.net/auth/2.0/server']")
    end
  end
end

describe "Requesting a user's xrds" do
  before(:each) do
    @user = Hancock::User.gen
  end

  it "renders the users idp page" do
    get "/sso/users/#{@user.id}"

    last_response.headers['Content-Type'].should eql('application/xrds+xml')
    last_response.headers['X-XRDS-Location'].should eql("http://example.org/sso/users/#{@user.id}")
    last_response.body.should have_xpath("//xrd/service[uri='http://example.org/sso']")
    last_response.body.should have_xpath("//xrd/service[type='http://specs.openid.net/auth/2.0/signon']")
  end
end
