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
        app.post '/users/login' do
          @user = ::Hancock::User.authenticate(params['email'], params['password'])
          if @user
            session[:user_id] = @user.id
          end
          ensure_authenticated
          redirect '/'
        end
      end
    end
  end
  register Hancock::Users
end
