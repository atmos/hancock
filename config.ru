#  thin start -p PORT -R config.ru
require File.join(File.dirname(__FILE__), 'lib', 'hancock')
require 'sinatra'

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

set :environment, :development
run Hancock::App
