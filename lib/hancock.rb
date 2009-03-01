require 'rubygems'
gem 'dm-core', '~>0.9.10'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
gem 'ruby-openid', '~>2.1.2'
require 'openid'
require 'openid/store/filesystem'
gem 'sinatra', '~>0.9.1'
require 'sinatra/base'
gem 'guid', '~>0.1.1'
require 'guid'

module Hancock
end

require File.expand_path(File.dirname(__FILE__)+'/hancock/models/user')
require File.expand_path(File.dirname(__FILE__)+'/hancock/models/consumer')
require File.expand_path(File.dirname(__FILE__)+'/hancock/sinatra/defaults')
require File.expand_path(File.dirname(__FILE__)+'/hancock/sinatra/users')
require File.expand_path(File.dirname(__FILE__)+'/hancock/sinatra/openid_server')

module Hancock
  class App < Sinatra::Default
    register Sinatra::Hancock::Defaults
    register Sinatra::Hancock::Users
    register Sinatra::Hancock::OpenIDServer
  end
end
