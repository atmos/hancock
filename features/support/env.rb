require File.join(File.dirname(__FILE__), '..', '..', 'spec', 'spec_helper')

class Webrat::Field
  def escaped_value
    @value.to_s
  end
end

module HancockAppHelper
  def app
    Hancock::TestApp.app
  end

  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  include Hancock::Matchers
end

World(HancockAppHelper)

Before do
  DataMapper.auto_migrate!
  visit '/sso/logout'  # log us out if we're logged in
end
