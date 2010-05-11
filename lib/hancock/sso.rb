require File.dirname(__FILE__) + '/sso/sessions'
require File.dirname(__FILE__) + '/sso/openid'

module Hancock
  module SSO
    class LogMeOut < StandardError; end
    class Forbidden < StandardError; end
    class BadRequest < StandardError; end
    class RouteMeHome < StandardError; end
    class Unauthenticated < StandardError; end

    SESSION_USER_KEY      = 'hancock.user.id'
    SESSION_OID_REQ_KEY   = 'hancock.oidreq.id'
    SESSION_RETURN_TO_KEY = 'hancock.return_to'

    def self.app
      @app ||= Rack::Builder.app do
        run ::Hancock::SSO::App
      end
    end

    class App < Sinatra::Base
      disable :show_exceptions

      register ::Hancock::SSO::Sessions
      register ::Hancock::SSO::OpenIdServer
    end
  end
end
