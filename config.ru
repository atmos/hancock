#  thin start -p PORT -R config.ru
require File.join(File.dirname(__FILE__), 'lib', 'hancock')

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/development.db")
DataMapper.auto_migrate!

consumer = Hancock::Consumer.create(:url => 'http://localhost:5000/login', :internal => false)

Hancock::App.set :environment, :production
run Hancock::App
