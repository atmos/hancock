require 'rubygems'
require 'pp'
gem 'selenium-client', '~>1.2.10'
gem 'rspec', '~>1.1.12'
require 'spec'
require 'sinatra/test'
require 'dm-sweatshop'

$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'hancock'
gem 'webrat', '~>0.4.2'
require 'webrat/sinatra'
require 'webrat/selenium'

require File.expand_path(File.dirname(__FILE__) + '/fixtures')
DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

Webrat.configure do |config|
  config.mode = :sinatra
  config.application_port = 4567
  config.application_framework = :sinatra
  if ENV['SELENIUM'].nil?
    config.mode = :sinatra
  else
    config.mode = :selenium
  end
end

Spec::Runner.configure do |config|
  config.include(Sinatra::Test)
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)

  config.before(:each) do
    Hancock::App.set :environment, :test
    @app = Rack::Builder.new {
      run Hancock::App
    }
  end
end
