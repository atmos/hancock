#  ~/p/hancock/bin/shotgun -p PORT config.ru
require File.join(File.dirname(__FILE__), '..', '..', 'vendor', 'gems', 'environments', 'default')
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'hancock'))

DataMapper.setup(:default, "sqlite3://#{File.dirname(__FILE__)}/development.rb")
DataMapper.auto_migrate!

Hancock::Consumer.create(:url => 'http://localhost:3000/sso/login', :label => 'Rails Dev', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:4000/sso/login', :label => 'Merb Dev', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:9292/sso/login', :label => 'Rack Fans', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:9393/sso/login', :label => 'Shotgun Fans', :internal => false)

class Dragon < Hancock::App
  get '/' do
    redirect '/sso/login' unless session['hancock_server_user_id']
    erb "<h2>Hello <%= session_user.name %><!-- <%= session.inspect %>"
  end
end
run Dragon
