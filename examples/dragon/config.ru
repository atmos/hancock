#  thin start -p PORT -R config.ru
require 'ruby-debug'
gem 'sinatra', '~>0.9.1'
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib', 'hancock'))

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/development.db")
DataMapper.auto_migrate!

Sinatra::Mailer.delivery_method = :test_send # don't really send email notifications

Hancock::Consumer.create(:url => 'http://localhost:5000/sso/login', :label => 'Local Dev', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:5001/sso/login', :label => 'Human Resources', :internal => true)
Hancock::Consumer.create(:url => 'http://localhost:5002/sso/login', :label => 'Remote Dev', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:5003/sso/login', :label => 'Remote Calendaring', :internal => false)
Hancock::Consumer.create(:url => 'http://localhost:5004/sso/login', :label => 'Break Dance Pool', :internal => true)
Hancock::Consumer.create(:url => 'http://localhost:5003/sso/login', :label => 'Library Book Reminder', :internal => false)

class Dragon < Hancock::App
  set :views,  'views'
  set :public, 'public'
  set :environment, :production

  set :provider_name, 'Example SSO Provider'
  set :do_not_reply, 'sso@example.com'

  get '/' do
    redirect '/sso/login' unless session[:user_id]
    erb "<h2>Hello <%= session[:first_name] %><!-- <%= session.inspect %>"
  end
end
run Dragon
