require 'rubygems'
require 'pp'
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'hancock'

require 'spec'
require 'dm-sweatshop'
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
  def app
    Hancock::App.tap do |app| 
      app.set :environment, :test
      disable :run, :reload
    end
  end
  config.include(Sinatra::Test)
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)
  config.include(Webrat::Selenium::Matchers)

  config.before(:each) do
  end
end
