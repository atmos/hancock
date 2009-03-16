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

gem 'rack-test', '~>0.1.0'
require 'rack/test'

require File.expand_path(File.dirname(__FILE__) + '/app')
require File.expand_path(File.dirname(__FILE__) + '/matchers')
require File.expand_path(File.dirname(__FILE__) + '/fixtures')

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!
Sinatra::Mailer.delivery_method = :test_send

Webrat.configure do |config|
  if ENV['SELENIUM'].nil?
    config.mode = :sinatra
  else
    config.mode = :selenium
    config.application_framework = :sinatra
    config.application_port = 4567
    require 'webrat/selenium'
  end
end

Hancock::App.set :environment, :development
Hancock::App.set :email_address, 'sso@example.com'

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
  config.after do
    Sinatra::Mailer::Email.deliveries = [ ]
  end
  unless ENV['SELENIUM'].nil?
    config.include(Webrat::Selenium::Methods)
    config.include(Webrat::Selenium::Matchers)
  end
end
