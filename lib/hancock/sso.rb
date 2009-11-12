require 'hancock/sso/helpers/sessions'
require 'hancock/sso/sessions'

require 'hancock/sso/helpers/sso'
require 'hancock/sso/sso'

module Hancock
  module SSO
    def self.app
      @app ||= Rack::Builder.app do
        run ::Hancock::SSO::App
      end
    end
    class App < Sinatra::Base
      disable :show_exceptions

      set :sreg_params, [:id, :email, :first_name, :last_name, :internal, :admin]
      register ::Hancock::Sessions
      register ::Hancock::OpenIDServer
    end
  end
end
