module Sinatra
  module Hancock
    module Sessions
      def self.sessions_template(file)
        template = File.expand_path(File.dirname(__FILE__)+'/views/')
        File.read("#{template}/#{file}.haml")
      end

      module Helpers
        def login_as(user)
          if user.nil?
            session.delete(:hancock_server_user_id)
          else
            session[:hancock_server_user_id] = user.id
          end
        end

        def session_user
          session[:hancock_server_user_id].nil? ?
            nil : ::Hancock::User.get(session[:hancock_server_user_id])
        end

        def session_return_to
          session[:hancock_server_return_to]
        end

        def session_cleanup
          session.reject! { |key,value| key != :hancock_server_user_id }
        end

        def ensure_authenticated
          if trust_root = session_return_to
            forbidden! unless ::Hancock::Consumer.allowed?(trust_root)
          end
          throw(:halt, [401, haml(:unauthenticated)]) unless session_user
        end

        def forbidden!
          throw :halt, [403, 'Forbidden']
        end
      end

      def self.registered(app)
        app.send(:include, Sinatra::Hancock::Sessions::Helpers)
        app.template(:unauthenticated) { sessions_template('unauthenticated') }

        app.get '/sso/login' do
          ensure_authenticated
          redirect '/'
        end

        app.post '/sso/login' do
          @user = ::Hancock::User.authenticate(params['email'], params['password'])
          login_as(@user)
          ensure_authenticated
          redirect session_return_to || '/'
        end

        app.get '/sso/logout' do
          session.clear
          redirect '/'
        end
      end
    end
  end
end
