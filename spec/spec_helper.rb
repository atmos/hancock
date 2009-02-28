require 'rubygems'
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'spec'
require 'hancock'
require 'dm-sweatshop'

Spec::Runner.configure do |config|
  # config.before(:each) do
  # end
end

Hancock::User.fix {{
  :email      => /\w+@example.org/,
  :first_name => /\w+/,
  :last_name  => /\w+/
}}

Hancock::Consumer.fix(:internal) {{
  :url      => %r!http://(\w+).example.org/login!,
  :label    => /(\w+) (\w+)/,
  :internal => true
}}

Hancock::Consumer.fix(:visible_to_all) {{
  :url      => %r!http://(\w+).consumerapp.com/login!,
  :label    => /(\w+) (\w+)/,
  :internal => false
}}

Hancock::Consumer.fix(:hidden) {{
  :url      => 'http://localhost:9292/login',
  :internal => false
}}
