#  bundle exec shotgun -p PORT config.ru
require 'rubygems'
require 'bundler/setup'

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'hancock'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec', 'helpers', 'app'))

class MyAuthenticatedUser
  def self.authenticated?(username, password)
    username == 'atmos' && password == 'hancock'
  end
end
Hancock::User.authentication_class = MyAuthenticatedUser

use Rack::Static, :urls => ["/css", "/img"], :root => "public"
run Hancock::TestApp.app
