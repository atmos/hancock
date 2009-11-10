require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'

require 'openid'
require 'openid/store/filesystem'
require 'openid/extensions/sreg'

require 'sinatra/base'
require 'haml/util'
require 'haml/engine'
require 'guid'
require 'json'
require 'rack/contrib/accept_format'

lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'hancock'))

%w(sessions sso).each do |lib|
  require File.join(lib_dir, 'sso', 'helpers', lib)
  require File.join(lib_dir, 'sso', lib)
end
require File.join(lib_dir, 'api')
require File.join(lib_dir, 'sso')
require File.join(lib_dir, 'models', 'model')
require File.join(lib_dir, 'models', 'user')
require File.join(lib_dir, 'models', 'consumer')
