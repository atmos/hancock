require 'rubygems'
require 'pp'
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'spec'
require 'hancock'
require 'dm-sweatshop'

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

Spec::Runner.configure do |config|
  # config.before(:each) do
  # end
end

#glhf
Hancock::User.fix {{
  :email                 => /\w+@\w+.\w{2,3}/.gen.downcase,
  :first_name            => /\w+/.gen.capitalize,
  :last_name             => /\w+/.gen.capitalize,
  :password              => 'lolerskates',
  :password_confirmation => 'lolerskates',
  :salt                  => (salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--email--")),
  :crypted_password      => Hancock::User.encrypt('lolerskates', salt)
}}

Hancock::Consumer.fix(:internal) {{
  :url      => %r!http://(\w+).example.org/login!.gen.downcase,
  :label    => /(\w+) (\w+)/.gen,
  :internal => true
}}

Hancock::Consumer.fix(:visible_to_all) {{
  :url      => %r!http://(\w+).consumerapp.com/login!.gen.downcase,
  :label    => /(\w+) (\w+)/.gen,
  :internal => false
}}

Hancock::Consumer.fix(:hidden) {{
  :url      => 'http://localhost:9292/login',
  :internal => false
}}
