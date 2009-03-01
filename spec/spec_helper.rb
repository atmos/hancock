require 'rubygems'
require 'pp'
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'sinatra'
require 'spec'
require 'hancock'
require 'dm-sweatshop'
gem 'webrat', '~>0.4.1'
require 'webrat/sinatra'

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
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)

  config.before(:each) do
  end
end
