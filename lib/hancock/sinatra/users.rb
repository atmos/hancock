module Sinatra
  module Hancock
    module Users
      module Helpers
      end

      def self.registered(app)
        app.send(:include, Sinatra::Hancock::Users::Helpers)
        app.get '/users' do
          'ZOMG'
        end
      end
    end
  end
  register Hancock::Users
end
