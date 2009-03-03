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
        app.get '/users/logout' do
          session.clear
          redirect '/'
        end
        app.get '/users/signup' do
          haml :signup
        end

        app.post '/users/signup' do
          Hancock::User.new(:email      => params['email'],
                            :first_name => params['first_name'],
                            :last_name  => params['last_name'])
          if @user.save
            haml :signup_success
          else
            haml :signup
          end
        end
      end
    end
  end
  register Hancock::Users
end
