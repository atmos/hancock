#  thin start -p PORT -R config.ru
require 'ruby-debug'
gem 'sinatra', '~>0.9.1'
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'hancock'))

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/development.db")
DataMapper.auto_migrate!

Hancock::Consumer.create(:url => 'http://localhost:5000/sso/login', :label => 'Local Dev', :internal => false)

Hancock::App.set :views,  'views'
Hancock::App.set :public, 'public'
Hancock::App.set :environment, :production
run Hancock::App
