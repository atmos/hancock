module Sinatra
  module Hancock
    module OpenIDServer
      module Helpers
        def server
          if @server.nil?
            server_url = 'http://localhost:9292/'
            dir = File.join(Dir.tmpdir, 'openid-store')
            store = OpenID::Store::Filesystem.new(dir)
            @server = OpenID::Server::Server.new(store, server_url)
          end
          return @server
        end

        def render_response(oidresp)
          if oidresp.needs_signing
            signed_response = server.signatory.sign(oidresp)
          end
          web_response = server.encode_response(oidresp)

          case web_response.code
          when 200
            web_response.body

          when 302
            session.delete(:return_to)
            redirect web_response.headers['location']
          else
            web_response.body
          end
        end

        def session_user
          User.get(session[:user_id])
        end

        def url_for_user
          absolute_url(:user, {:id => session.user.contact_id})
        end

        def ensure_authenticated
          throw(:halt, [401, 'Unauthorized']) unless session_user
        end

        def forbidden!
          throw :halt, [403, 'Forbidden']
        end
      end

      def self.registered(app)
        app.send(:include, Sinatra::Hancock::OpenIDServer::Helpers)
        app.get '/' do
          begin
            oidreq = server.decode_request(params)
          rescue OpenID::Server::ProtocolError => e
            oidreq = session[:last_oidreq]
          end
          throw(:halt, [400, 'Bad Request']) unless oidreq

          oidresp = nil
          if oidreq.kind_of?(OpenID::Server::CheckIDRequest)
            session[:last_oidreq] = oidreq
            session[:return_to] = [url(:servers)]

            ensure_authenticated

            unless oidreq.identity == url_for_user
              forbidden!
            end
            forbidden! unless Hancock::Consumer.allowed?(oidreq.trust_root) 

            oidresp = oidreq.answer(true, nil, oidreq.identity)
          else
            oidresp = server.handle_request(oidreq) #associate and more?
          end

          render_response(oidresp)
        end
      end
    end
  end
  register Hancock::OpenIDServer
end
