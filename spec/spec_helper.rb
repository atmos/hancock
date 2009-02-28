require 'rubygems'
require 'pp'
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'spec'
require 'hancock'
require 'dm-sweatshop'

require File.expand_path(File.dirname(__FILE__) + '/fixtures')
DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

Spec::Runner.configure do |config|
  # config.before(:each) do
  # end
end

