require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "Hancock::Consumer API" do
  def app
    Hancock::API.app
  end
  describe '(GET /consumers)' do
    it 'returns a list of consumers in json format' do
      pending
      10.times { Hancock::Consumer.gen }
      response = get('/consumers', { }, { 'HTTP_ACCEPT' => 'application/json'})
      json = JSON.parse(response.body)
      json.should have(10).entries
    end
  end
  describe '(POST /consumers)' do
    it 'creates a consumer' do
      pending
      size = Hancock::Consumer.count
      params = { :email => /\w{3,8}@\w{6,8}.\w{2,3}/.gen.downcase, :first_name => Randgen.first_name, :last_name => Randgen.last_name }
      lambda { post('/consumers', params, { 'HTTP_ACCEPT' => 'application/json'}) }.should 
        change(Hancock::Consumer, :count).from(size).to(size + 1)
    end
  end
  describe "given an existing user" do
    before(:each) { @consumer = Hancock::Consumer.gen(:internal) }
    describe '(GET /consumers/:id.json)' do
      it 'returns user information given an id' do
        pending
        response = get('/consumers/1', {}, { 'HTTP_ACCEPT' => 'application/json'})
        json = JSON.parse(response.body)
        Hancock::Consumer.attributes_for_api.each do |key|
          json[key].should_not be_nil
        end
      end
    end
    describe '(PUT /consumers/:id.json)' do
      it 'updates a user' do
        pending
        email = /\w{3,8}@\w{6,8}.\w{2,3}/.gen.downcase
        response = put("/consumers/#{@consumer.id}", {:email => email }, { 'HTTP_ACCEPT' => 'application/json'})
        json = JSON.parse(response.body)
        json['email'].should          eql(email)
        json['first_name'].should_not be_nil
        json['last_name'].should_not  be_nil
        json['internal'].should       be_false
        json['verified'].should       be_true
      end
    end
    describe '(DELETE /consumers/:id.json)' do
      it 'destroys a user' do
        pending
        size = Hancock::Consumer.count
        lambda { delete("/consumers/#{@consumer.id}", { }, { 'HTTP_ACCEPT' => 'application/json'}) }.should 
          change(Hancock::Consumer, :count).from(size).to(size - 1)
      end
    end
  end
end
