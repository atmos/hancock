#  thin start -p PORT -R config.ru
require File.join(File.dirname(__FILE__), 'lib', 'hancock')
require 'sinatra'

set :environment, :development
run Hancock::App
