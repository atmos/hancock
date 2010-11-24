module Hancock
  module TestApp
    module Helpers
      def landing_page
        "%h2 Hello #{session_user.inspect}!"
      end

      def unauthenticated
        <<-HAML
%fieldset
  %legend You need to log in, buddy.
  %form{:action => '/sso/login', :method => 'POST'}
    %label{:for => 'email'}
      Email:
      %input{:type => 'text', :name => 'email'}
      %br
    %label{:for => 'password'}
      Password:
      %input{:type => 'password', :name => 'password'}
      %br
    %input{:type => 'submit', :value => 'Login'}
    or
    %a{:href => '/sso/signup'} Signup
HAML
       end

    end

    def self.registered(app)
      app.helpers Helpers
      app.get '/' do
        ensure_authenticated
        haml landing_page
      end
    end

    def self.app
      @app ||= Rack::Builder.new do
        use Rack::Session::Cookie
        run SsoServer
      end
    end

    class SsoServer < ::Hancock::SSO::App
      enable  :raise_errors
      disable :show_exceptions

      error Hancock::SSO::Unauthenticated do
        haml(unauthenticated)
      end

      error Hancock::SSO::Forbidden do
        throw(:halt, [403, "Forbidden"])
      end

      error Hancock::SSO::BadRequest do
        throw(:halt, [400, "Bad Request"])
      end

      error Hancock::SSO::LogMeOut do
        redirect "/"
      end

      error Hancock::SSO::RouteMeHome do
        redirect "/"
      end

      register(Hancock::TestApp)
    end
  end
end
