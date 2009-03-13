require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "posting to /sso/login" do
  before(:each) do
    @user = Hancock::User.gen
    @consumer = Hancock::Consumer.gen(:internal)
  end
  describe "with a valid password" do
    it "should authenticate a user and redirect to /" do
      post '/sso/login', :email => @user.email, :password => @user.password
      last_response.status.should eql(302)
      last_response.headers['Location'].should eql('/')
    end
  end
  describe "with an invalid password" do
    it "should display a form to login" do
      post '/sso/login', :email => @user.email, :password => 's3cr3t'
      last_response.body.should be_a_login_form
    end
  end
end
describe "getting /sso/login" do
  before(:each) do
    @user = Hancock::User.gen
    @consumer = Hancock::Consumer.gen(:internal)
  end
  describe "with a valid session" do
    it "should redirect to the consumer w/ the id for openid discovery" do
      get '/sso/login', :return_to => @consumer.url

      post '/sso/login', :email => @user.email, :password => @user.password
      follow_redirect!

      get '/sso/login'
      last_response.status.should eql(302)

      uri = Addressable::URI.parse(last_response.headers['Location'])
      @consumer.url.should eql("#{uri.scheme}://#{uri.host}#{uri.path}")

      uri.query_values['id'].should eql("#{@user.id}")
    end

    describe "from an invalid consumer" do
      it "should return forbidden" do
        get '/sso/login', { 'return_to' => 'http://rogueconsumerapp.com/login' }

        login(@user)

        get '/sso/login', { 'return_to' => 'http://rogueconsumerapp.com/login' }

        last_response.status.should eql(403)
      end
    end
  end
  describe "without a valid session" do
    it "should prompt the user to login" do
      get '/sso/login', { 'return_to' => @consumer.url }
      last_response.body.should be_a_login_form
    end
  end
end
