module Sinatra
  module Hancock
    module Defaults
      module Helpers
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

      def self.registered(app)
        app.send(:include, Sinatra::Hancock::Defaults::Helpers)
        app.enable :sessions
      end
    end
  end
  register Hancock::Defaults
end
