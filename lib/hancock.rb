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

module Hancock; end
require File.expand_path(File.join(File.dirname(__FILE__), 'models'))
require File.expand_path(File.join(File.dirname(__FILE__), 'sso'))
require File.expand_path(File.join(File.dirname(__FILE__), 'api'))

module Hancock
  class ConfigurationError < StandardError; end

  class App < Sinatra::Base
    disable :show_exceptions

    set :sreg_params, [:id, :email, :first_name, :last_name, :internal, :admin]

    register Sinatra::Hancock::Sessions
    register Sinatra::Hancock::OpenIDServer
  end
end
