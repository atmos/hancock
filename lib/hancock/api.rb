require File.expand_path(File.join(File.dirname(__FILE__), 'api', 'user'))
require File.expand_path(File.join(File.dirname(__FILE__), 'api', 'consumer'))

module Hancock
  module API
    def self.app
      @app ||= Rack::Builder.app do
        use Users::App
        run Consumers::App
      end
    end
  end
end
