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

require File.expand_path(File.dirname(__FILE__)+'/models/user')
require File.expand_path(File.dirname(__FILE__)+'/models/consumer')

require File.expand_path(File.dirname(__FILE__)+'/sinatra/hancock/sessions')
require File.expand_path(File.dirname(__FILE__)+'/sinatra/hancock/openid_server')
require File.expand_path(File.dirname(__FILE__)+'/sinatra/api')

module Hancock
  class ConfigurationError < StandardError; end

  class App < Sinatra::Base
    disable :show_exceptions

    set :sreg_params, [:email, :first_name, :last_name, :internal]

    register Sinatra::Hancock::Sessions
    register Sinatra::Hancock::OpenIDServer
  end
end
