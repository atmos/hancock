require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /sso" do
  let(:user)      { 'atmos' }
  let(:password)  { 'hancock' }
  let(:consumer_url) { "http://foo.example.org" }
  let(:identity_url) { "http://example.org/sso/users/#{user}" }

  before(:all) do
    Hancock::User.authentication_class = MyUserClass
  end

  it "should throw a bad request if there aren't any openid params" do
    get '/sso'
    last_response.status.should eql(400)
  end

  describe "with openid mode of associate" do
    it "should respond with Diffie Hellman data in kv format" do
      session = OpenID::Consumer::AssociationManager.create_session("DH-SHA1")
      params =  {"openid.ns"           => 'http://specs.openid.net/auth/2.0',
                 "openid.mode"         => "associate",
                 "openid.session_type" => 'DH-SHA1',
                 "openid.assoc_type"   => 'HMAC-SHA1',
                 "openid.dh_consumer_public"=> session.get_request['dh_consumer_public']}

      get "/sso", params

      last_response.should be_an_openid_associate_response(session)
    end
  end

  describe "with openid mode of checkid_setup" do
    describe "authenticated" do
      it "should redirect to the consumer app" do
        params = {
            "openid.ns"         => "http://specs.openid.net/auth/2.0",
            "openid.mode"       => "checkid_setup",
            "openid.return_to"  => consumer_url,
            "openid.identity"   => identity_url,
            "openid.claimed_id" => identity_url
        }

        login(user, password)
        get "/sso", params
        last_response.should be_a_redirect_to_the_consumer(consumer_url, user)
      end
    end

    describe "unauthenticated user" do
      it "should require authentication" do
        params = {
          "openid.ns"         => "http://specs.openid.net/auth/2.0",
          "openid.mode"       => "checkid_setup",
          "openid.return_to"  => consumer_url,
          "openid.identity"   => identity_url,
          "openid.claimed_id" => identity_url
        }

        get "/sso", params
        last_response.body.should be_a_login_form
      end
    end
  end

  describe "with openid mode of checkid_immediate" do
    describe "unauthenticated user" do
      it "should require authentication" do
        params = {
          "openid.ns"         => "http://specs.openid.net/auth/2.0",
          "openid.mode"       => "checkid_immediate",
          "openid.return_to"  => consumer_url,
          "openid.identity"   => identity_url,
          "openid.claimed_id" => identity_url
        }

        get "/sso", params
        last_response.body.should be_a_login_form
      end
    end

    describe "authenticated user" do
      describe "with appropriate request parameters" do
        it "should redirect to the consumer app" do
          params = {
            "openid.ns"         => "http://specs.openid.net/auth/2.0",
            "openid.mode"       => "checkid_immediate",
            "openid.return_to"  => consumer_url,
            "openid.identity"   => identity_url,
            "openid.claimed_id" => identity_url
          }

          login(user, password)
          get "/sso", params
          last_response.should be_an_openid_immediate_response(consumer_url, user)
        end
      end
    end
  end
end
