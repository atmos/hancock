require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "Hancock::User API" do
  def app
    Hancock::API.app
  end
  describe '(GET /users)' do
    it 'returns a list of users in json format' do
      10.times { Hancock::User.gen }
      response = get('/users', { }, { 'HTTP_ACCEPT' => 'application/json'})
      json = JSON.parse(response.body)
      json.should have(10).entries
    end
  end
  describe '(POST /users)' do
    it 'creates a user' do
      size = Hancock::User.count
      params = { :email => /\w{3,8}@\w{6,8}.\w{2,3}/.gen.downcase, :first_name => Randgen.first_name, :last_name => Randgen.last_name }
      lambda { post('/users', params, { 'HTTP_ACCEPT' => 'application/json'}) }.should 
        change(Hancock::User, :count).from(size).to(size + 1)
    end
  end
  describe "given an existing user" do
    before(:each) { @user = Hancock::User.gen }
    describe '(GET /users/:id.json)' do
      it 'returns user information given an id' do
        response = get('/users/1', {}, { 'HTTP_ACCEPT' => 'application/json'})
        json = JSON.parse(response.body)
        Hancock::User.attributes_for_api.each do |key|
          json[key].should_not be_nil
        end
      end
    end
    describe '(PUT /users/:id.json)' do
      it 'updates a user' do
        email = /\w{3,8}@\w{6,8}.\w{2,3}/.gen.downcase
        response = put("/users/#{@user.id}", {:email => email }, { 'HTTP_ACCEPT' => 'application/json'})
        json = JSON.parse(response.body)
        json['email'].should          eql(email)
        json['first_name'].should_not be_nil
        json['last_name'].should_not  be_nil
        json['internal'].should       be_false
        json['verified'].should       be_true
      end
    end
    describe '(DELETE /users/:id.json)' do
      it 'destroys a user' do
        size = Hancock::User.count
        lambda { delete("/users/#{@user.id}", { }, { 'HTTP_ACCEPT' => 'application/json'}) }.should 
          change(Hancock::User, :count).from(size).to(size - 1)
      end
    end
  end
end
