module Hancock
  module API
    def self.app
      @app ||= Rack::Builder.app do
        use Users::App
        run Consumers::App
      end
    end
    module JSON
      class App < Sinatra::Base
        use Rack::AcceptFormat
        enable :methodoverride

        before do
          response['Content-Type'] = 'application/json'
        end
      end
    end
  end
end
require File.expand_path(File.join(File.dirname(__FILE__), 'api', 'user'))
require File.expand_path(File.join(File.dirname(__FILE__), 'api', 'consumer'))
