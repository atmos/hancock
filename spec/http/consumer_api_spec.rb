require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "Hancock::Consumer API" do
  def app
    Hancock::API.app
  end
  describe '(GET /consumers)' do
    it 'returns a list of consumers in json format' do
      10.times { Hancock::Consumer.gen(:internal) }
      response = get('/consumers', { }, { 'HTTP_ACCEPT' => 'application/json'})
      json = JSON.parse(response.body)
      json.should have(10).entries
    end
  end
  describe '(POST /consumers)' do
    it 'creates a consumer' do
      size = Hancock::Consumer.count
      params = { :url => "http://#{/\w{4,8}/.gen}.example.com", :label => /\w{4,12}/.gen }
      lambda { post('/consumers', params, { 'HTTP_ACCEPT' => 'application/json'}) }.should 
        change(Hancock::Consumer, :count).from(size).to(size + 1)
    end
    it 'creates an internal consumer' do
      size = Hancock::Consumer.count
      params = { :url => "http://#{/\w{4,8}/.gen}.example.com", :label => /\w{4,12}/.gen, :internal => 'true'  }
      lambda do
        response = post('/consumers', params, { 'HTTP_ACCEPT' => 'application/json'}) 
        pp response
      end.should change(Hancock::Consumer, :count).from(size).to(size + 1)
    end
  end
  describe "given an existing consumer" do
    before(:each) { @consumer = Hancock::Consumer.gen(:internal) }
    describe '(GET /consumers/:id.json)' do
      it 'returns consumer information given an id' do
        response = get("/consumers/#{@consumer.id}", {}, { 'HTTP_ACCEPT' => 'application/json'})
        json = JSON.parse(response.body)
        Hancock::Consumer.attributes_for_api.each do |key|
          json[key].should eql(@consumer.send(key))
        end
      end
    end
    describe '(PUT /consumers/:id.json)' do
      it 'updates a user' do
        @consumer.label = Randgen.last_name
        response = put("/consumers/#{@consumer.id}", {:label => @consumer.label}, { 'HTTP_ACCEPT' => 'application/json'})
        json = JSON.parse(response.body)
        Hancock::Consumer.attributes_for_api.each do |key|
          json[key].should eql(@consumer.send(key))
        end
      end
    end
    describe '(DELETE /consumers/:id.json)' do
      it 'destroys a user' do
        size = Hancock::Consumer.count
        lambda { delete("/consumers/#{@consumer.id}", { }, { 'HTTP_ACCEPT' => 'application/json'}) }.should 
          change(Hancock::Consumer, :count).from(size).to(size - 1)
      end
    end
  end
end
