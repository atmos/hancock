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
