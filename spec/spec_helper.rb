require 'pp'
require 'rubygems'
require 'bundler'
project_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

Bundler.setup(:runtime, :test)
require File.expand_path(File.join('..', '..', 'lib', 'hancock'), __FILE__)
Bundler.require(:test)

%w(app matchers fixtures).each do |helper|
  require File.join(project_root, 'spec', 'helpers', helper)
end

DataMapper.setup(:default, 'sqlite3::memory:')

Webrat.configure do |config|
  config.mode = :rack
  config.application_framework = :sinatra
  config.application_port = 4567
end

Spec::Runner.configure do |config|
  def app
    @app = Rack::Builder.app do
      use Rack::Session::Cookie
      run Hancock::SsoServer
    end
  end

  def login(user)
    post '/sso/login', :email => user.email, :password => user.password
  end

  config.include(Rack::Test::Methods)
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)
  config.include(Hancock::Matchers)
  config.before(:each) do
    DataMapper.auto_migrate!
  end
end
