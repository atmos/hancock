require 'pp'
require 'rubygems'

gem 'dm-core', '~>0.9.11'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'

gem 'ruby-openid', '~>2.1.7'
require 'openid'
require 'openid/store/filesystem'
require 'openid/extensions/sreg'

gem 'sinatra', '~>0.9.2'
require 'sinatra/base'
gem 'haml', '~>2.0.9'
require 'haml/engine'
require 'sass'

gem 'guid', '~>0.1.1'
require 'guid'

gem 'pony', '0.3'
require 'pony'

module Hancock; end

require File.expand_path(File.dirname(__FILE__)+'/models/user')
require File.expand_path(File.dirname(__FILE__)+'/models/consumer')

require File.expand_path(File.dirname(__FILE__)+'/sinatra/hancock/defaults')
require File.expand_path(File.dirname(__FILE__)+'/sinatra/hancock/sessions')
require File.expand_path(File.dirname(__FILE__)+'/sinatra/hancock/users')
require File.expand_path(File.dirname(__FILE__)+'/sinatra/hancock/openid_server')

module Hancock
  class ConfigurationError < StandardError; end

  class App < Sinatra::Default
    enable :sessions
    set :environment, ENV['RACK_ENV'] || 'development'
    #disable :raise_errors
    disable :show_exceptions

    set :sreg_params, [:email, :first_name, :last_name, :internal]
    set :provider_name, 'Hancock SSO Provider!'
    set :do_not_reply, nil
    set :smtp, { :domain => 'example.com' }

    error do
      pp env['sinatra.error']
    end

    register Sinatra::Hancock::Defaults
    register Sinatra::Hancock::Sessions
    register Sinatra::Hancock::Users
    register Sinatra::Hancock::OpenIDServer
  end
end
