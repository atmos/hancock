Bundler.require_env(:test)
require File.join(File.dirname(__FILE__), '..', 'lib', 'hancock')
require 'pp'
require 'spec'
require 'randexp'
require 'dm-sweatshop'

require 'webrat'
require 'rack/test'

require File.expand_path(File.dirname(__FILE__) + '/app')
require File.expand_path(File.dirname(__FILE__) + '/matchers')
require File.expand_path(File.dirname(__FILE__) + '/fixtures')

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

Webrat.configure do |config|
  config.mode = :rack
  config.application_framework = :sinatra
  config.application_port = 4567
end

Hancock::App.set :do_not_reply, 'sso@example.com'

Spec::Runner.configure do |config|
  def app
    @app = Rack::Builder.app do
      use Rack::Session::Cookie
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
  config.before(:each) do
    DataMapper.auto_migrate!
  end
end
