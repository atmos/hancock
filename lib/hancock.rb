gem 'dm-core', '~>0.9.10'
require 'dm-core'
require 'dm-validations'
gem 'ruby-openid', '~>2.1.2'
require 'openid'
gem 'sinatra', '~>0.9.1'
require 'sinatra/base'

module Hancock
  module Sinatra
  end
end

require File.expand_path(File.dirname(__FILE__)+'/models/user')
require File.expand_path(File.dirname(__FILE__)+'/models/consumer')
