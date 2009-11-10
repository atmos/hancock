module Hancock
  module OpenIDServer
    module Helpers
      def server
        if @server.nil?
          store = OpenID::Store::Filesystem.new(File.join(Dir.tmpdir, 'openid-store'))
          @server = OpenID::Server::Server.new(store, absolute_url('/sso'))
        end
        return @server
      end

      def url_for_user
        absolute_url("/sso/users/#{session_user.id}")
      end

      def render_response(oidresp)
        if oidresp.needs_signing
          signed_response = server.signatory.sign(oidresp)
        end
        web_response = server.encode_response(oidresp)

        case web_response.code
        when 302
          redirect web_response.headers['location']
        else
          web_response.body
        end
      end

      def absolute_url(suffix = nil)
        port_part = case request.scheme
                    when "http"
                      request.port == 80 ? "" : ":#{request.port}"
                    when "https"
                      request.port == 443 ? "" : ":#{request.port}"
                    end
          "#{request.scheme}://#{request.host}#{port_part}#{suffix}"
      end
    end
  end
end
