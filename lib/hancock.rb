require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'

require 'openid'
require 'openid/store/filesystem'
require 'openid/extensions/sreg'

require 'sinatra/base'
require 'haml/engine'
require 'guid'
require 'json'
require 'rack/contrib/accept_format'

lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'hancock'))

require File.join(lib_dir, 'api')
require File.join(lib_dir, 'sso', 'sessions')
require File.join(lib_dir, 'sso', 'openid_server')
require File.join(lib_dir, 'models', 'model')
require File.join(lib_dir, 'models', 'user')
require File.join(lib_dir, 'models', 'consumer')

module Hancock
  class ConfigurationError < StandardError; end

  class App < Sinatra::Base
    disable :show_exceptions

    set :sreg_params, [:id, :email, :first_name, :last_name, :internal, :admin]

    register Sinatra::Hancock::Sessions
    register Sinatra::Hancock::OpenIDServer
  end
end
