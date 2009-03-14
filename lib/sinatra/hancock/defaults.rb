module Sinatra
  module Hancock
    module Defaults
      module Helpers
        def forbidden!
          throw :halt, [403, 'Forbidden']
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
      def self.registered(app)
        app.helpers Helpers
      end
    end
  end
  register Hancock::Defaults
end
