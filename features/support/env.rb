require File.expand_path(File.dirname(__FILE__)+'/../../spec/spec_helper')
require 'haml'

Hancock::App.set :environment, :development

World do
  def app
    @app = Rack::Builder.new do
      run Hancock::App
    end
  end
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  include Hancock::Matchers
end

class Webrat::Field
  def escaped_value
    @value.to_s
  end
end
