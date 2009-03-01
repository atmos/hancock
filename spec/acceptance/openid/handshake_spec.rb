require File.expand_path(File.dirname(__FILE__)+'/../../spec_helper')

describe "visiting /openid" do
  def app
    Hancock::App.tap do |app| 
      app.set :environment, :test
      disable :run, :reload
    end
  end
  it "should sign the user up properly" do
    visit '/openid'
    puts response_body
  end
end
