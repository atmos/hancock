module Hancock
  module SSO
    module Sessions
      module Helpers
        def session_user
          session[Hancock::SSO::SESSION_USER_KEY]
        end

        def session_return_to
          session[Hancock::SSO::SESSION_OID_REQ_KEY] &&
          session[Hancock::SSO::SESSION_OID_REQ_KEY].return_to
        end

        def ensure_authenticated
          raise Hancock::SSO::Unauthenticated unless session_user
        end
      end

      def self.registered(app)
        app.helpers Helpers

        app.get '/sso/login' do
          ensure_authenticated
          raise Hancock::SSO::RouteMeHome
        end

        app.post '/sso/login' do
          user = ::Hancock::User.authenticated?(params['username'], params['password'])
          session[Hancock::SSO::SESSION_USER_KEY] = params['username']
          ensure_authenticated
          redirect session_return_to || raise(Hancock::SSO::RouteMeHome)
        end

        app.get '/sso/logout' do
          session.clear
          raise Hancock::SSO::LogMeOut
        end
      end
    end
  end
end
