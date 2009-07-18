require 'rubygems'
require 'pp'
gem 'rspec', '~>1.2.0'
require 'spec'
require 'randexp'
require 'dm-sweatshop'

$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'hancock'
gem 'webrat', '~>0.4.4'
require 'webrat'

gem 'rack-test', '>=0.4.0'
require 'rack/test'

require File.expand_path(File.dirname(__FILE__) + '/app')
require File.expand_path(File.dirname(__FILE__) + '/matchers')
require File.expand_path(File.dirname(__FILE__) + '/fixtures')

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

Webrat.configure do |config|
  if ENV['SELENIUM'].nil?
    config.mode = :rack_test
  else
    gem 'selenium-client', '~>1.2.15'
    config.mode = :selenium
    config.application_framework = :sinatra
    config.application_port = 4567
    require 'webrat/selenium'
  end
end

Hancock::App.set :environment, :development
Hancock::App.set :do_not_reply, 'sso@example.com'

Spec::Runner.configure do |config|
  def app
    @app = Rack::Builder.new do
      run Hancock::App
    end
  end

  def login(user)
    post '/sso/login', :email => user.email, :password => user.password
  end

  config.include(Rack::Test::Methods)
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)
  config.include(Hancock::Matchers)
  unless ENV['SELENIUM'].nil?
    config.include(Webrat::Selenium::Methods)
    config.include(Webrat::Selenium::Matchers)
  end
end
