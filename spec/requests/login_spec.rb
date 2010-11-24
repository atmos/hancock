require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "posting to /sso/login" do
  before(:all) do
    Hancock::User.authentication_class = MyUserClass
  end

  describe "with a valid password" do
    it "should authenticate a user and redirect to /" do
      login('atmos', 'hancock')

      last_response.status.should eql(302)
      last_response.headers['Location'].should eql('http://example.org/')
    end
  end
  describe "with an invalid password" do
    it "should display a form to login" do
      login('atmos', 'xxxxxx')

      last_response.body.should be_a_login_form
    end
  end
end

describe "getting /sso/login" do
  let(:consumer_url) { "http://foo.example.org" }

  describe "without a valid session" do
    it "should prompt the user to login" do
      get '/sso/login', { 'return_to' => consumer_url }
      last_response.body.should be_a_login_form
    end
  end
end
