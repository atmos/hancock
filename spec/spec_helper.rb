require 'pp'
require 'rubygems'
require 'bundler'
project_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

Bundler.setup(:runtime, :test)
require File.expand_path(File.join('..', '..', 'lib', 'hancock'), __FILE__)

Bundler.require(:test)

require File.join(project_root, 'spec', 'helpers', 'app')
require File.join(project_root, 'spec', 'helpers', 'matchers')

Webrat.configure do |config|
  config.mode = :rack
  config.application_framework = :sinatra
  config.application_port = 4567
end

class MyUserClass
  def self.authenticated?(username, password)
    username == 'atmos' && password == 'hancock'
  end
end

Rspec.configure do |config|
  def app
    Hancock::TestApp.app
  end

  def login(username, password)
    post '/sso/login', :username => username, :password => password
  end

  config.include(Rack::Test::Methods)
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)
  config.include(Hancock::Matchers)
end
