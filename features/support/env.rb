ENV['RACK_ENV'] ||= 'test'

require 'rubygems'
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'hancock')
gem 'rspec', '~>1.2.0'
require 'spec'
require 'randexp'
require 'dm-sweatshop'
gem 'webrat', '~>0.4.4'
require 'webrat'
gem 'rack-test', '>=0.4.0'
require 'rack/test'

require File.join(File.dirname(__FILE__), 'app')
require File.join(File.dirname(__FILE__), '..', '..', 'spec', 'fixtures')
require File.join(File.dirname(__FILE__), '..', '..', 'spec', 'matchers')

DataMapper.setup(:default, 'sqlite3::memory:')

Webrat.configure do |config|
  config.mode = :rack_test
  config.application_framework = :rack
  config.application_port = 4567
end

World do
  def app
    @app ||= Rack::Builder.new do
      run MySweetSSOServer
    end
  end
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  include Hancock::Matchers
end

class Webrat::Field
  def escaped_value
    @value.to_s
  end
end

Before do
  DataMapper.auto_migrate!
  visit '/sso/logout'  # log us out if we're logged in
end
