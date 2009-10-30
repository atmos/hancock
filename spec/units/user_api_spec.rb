require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "the user api" do
  before(:each) do
    10.times do
      Hancock::User.gen
    end
  end

  def app
    @app ||= Rack::Builder.app do
      run Hancock::API::App
    end
  end

  describe 'requesting /' do
    it 'returns a list of users in json format' do
      response = get('/users', { }, { 'HTTP_ACCEPT' => 'application/json'})
      json = JSON.parse(response.body)
      json.should have(10).entries
    end
    it 'returns a user information given an id' do
      response = get('/users/1', {}, { 'HTTP_ACCEPT' => 'application/json'})
      json = JSON.parse(response.body)
      %w(id first_name last_name verified internal email).each do |key|
        json[key].should_not be_nil
      end
    end
  end
end
