require 'sinatra'
require File.join(File.dirname(__FILE__), 'lib', 'hancock')

set :environment, :development
run Hancock::App
