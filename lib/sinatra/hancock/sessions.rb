module Sinatra
  module Hancock
    module Sessions
      def self.sessions_template(file)
        template = File.expand_path(File.dirname(__FILE__)+'/views/sessions')
        File.read("#{template}/#{file}.haml")
      end

      module Helpers
        def session_user
          session['hancock_server_user_id'].nil? ? 
            nil : ::Hancock::User.get(session['hancock_server_user_id'])
        end

        def ensure_authenticated
          if trust_root = session['hancock_server_return_to'] || params['return_to']
            if ::Hancock::Consumer.allowed?(trust_root)
              if session_user
                redirect "#{trust_root}?id=#{session_user.id}"
              else
                session['hancock_server_return_to'] = trust_root
              end
            else
              forbidden!
            end
          end
          throw(:halt, [401, haml(:unauthenticated)]) unless session_user
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
          if @user
            session['hancock_server_user_id'] = @user.id
          end
          ensure_authenticated
          redirect session['hancock_server_return_to'] || '/'
        end

        app.get '/sso/logout' do
          session.clear
          redirect '/'
        end
      end
    end
  end
  register Hancock::Sessions
end
