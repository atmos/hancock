module Sinatra
  module Hancock
    module Defaults
      module Helpers
      end

      def self.registered(app)
        app.enable :sessions
      end
    end
  end
  register Hancock::Defaults
end
