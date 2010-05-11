#  ~/p/hancock/bin/shotgun -p PORT config.ru
Bundler.require_env(:release)
require 'do_sqlite3'
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'hancock'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec', 'helpers', 'app'))

DataMapper.setup(:default, "sqlite3://#{File.expand_path(File.dirname(__FILE__))}/development.db")
DataMapper.auto_migrate!

Hancock::Consumer.create(:url => 'http://localhost:3000/sso/login', :label => 'Rails Dev', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:4000/sso/login', :label => 'Merb Dev', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:4567/sso/login', :label => 'Sinatra Fans', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:9292/sso/login', :label => 'Rack Fans', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:9393/sso/login', :label => 'Shotgun Fans', :internal => false)

run Hancock::TestApp.app
