#  thin start -p PORT -R config.ru
require File.join(File.dirname(__FILE__), 'lib', 'hancock')

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/development.db")
DataMapper.auto_migrate!

Hancock::App.set :environment, :production
run Hancock::App
