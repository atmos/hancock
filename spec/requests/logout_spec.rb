require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /sso/logout" do
  describe "when authenticated" do
    it "clears the session and redirects to /" do
      login('atmos', 'hancock')

      get '/sso/logout'
      last_response.status.should eql(302)
      last_response.headers['Location'].should eql('http://example.org/')
    end
  end
  describe "when unauthenticated" do
    it "redirects to /" do
      get '/sso/logout'
      last_response.status.should eql(302)
      last_response.headers['Location'].should eql('http://example.org/')
    end
  end
end
