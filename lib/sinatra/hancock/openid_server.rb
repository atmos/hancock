module Sinatra
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
      end

      def self.registered(app)
        app.disable :show_exceptions
        app.send(:include, Sinatra::Hancock::OpenIDServer::Helpers)

        [:get, :post].each do |meth|
          app.send(meth, '/sso') do
            begin
              oidreq = server.decode_request(params)
            rescue OpenID::Server::ProtocolError => e
              oidreq = session[:hancock_server_last_oidreq]
            end
            throw(:halt, [400, 'Bad Request']) unless oidreq

            oidresp = nil
            if oidreq.kind_of?(OpenID::Server::CheckIDRequest)
              session[:hancock_server_last_oidreq] = oidreq
              session[:hancock_server_return_to] = oidreq.return_to

              ensure_authenticated
              forbidden! unless ::Hancock::Consumer.allowed?(oidreq.trust_root) 

              oidreq.identity = oidreq.claimed_id = url_for_user
              oidresp = oidreq.answer(true, nil, oidreq.identity)
              sreg_data = {
                'last_name'  => session_user.last_name,
                'first_name' => session_user.first_name,
                'email'      => session_user.email
              }
              oidresp.add_extension(OpenID::SReg::Response.new(sreg_data))
            else #associate
              oidresp = server.handle_request(oidreq) 
            end
            render_response(oidresp)
          end
        end
      end
    end
  end
end
