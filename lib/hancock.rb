require 'extlib'
require 'dm-core'
require 'dm-types'
require 'dm-aggregates'
require 'dm-migrations'
require 'dm-timestamps'
require 'dm-validations'

require 'openid'
require 'openid/store/filesystem'
require 'openid/extensions/sreg'

require 'sinatra/base'
require 'haml/util'
require 'haml/engine'
require 'guid'
require 'json'
require 'rack/contrib/accept_format'

lib_dir = File.expand_path(File.join(File.dirname(__FILE__)))

require File.join(lib_dir, 'hancock', 'api')
require File.join(lib_dir, 'hancock', 'sso')
require File.join(lib_dir, 'hancock', 'models', 'model')
require File.join(lib_dir, 'hancock', 'models', 'user')
require File.join(lib_dir, 'hancock', 'models', 'consumer')
