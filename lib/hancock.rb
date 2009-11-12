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

$:.push File.expand_path(File.join(File.dirname(__FILE__)))

require 'hancock/api'
require 'hancock/sso'
require 'hancock/models/model'
require 'hancock/models/user'
require 'hancock/models/consumer'
