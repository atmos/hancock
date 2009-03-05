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
        def landing_page
          <<-HAML
%h3 Hello #{session_user.first_name} #{session_user.last_name}!
- unless @consumers.empty?
  %ul#consumers
    - @consumers.each do |consumer|
      %li
        %a{:href => consumer.url}= consumer.label
HAML
        end
      end

      def self.registered(app)
        app.send(:include, Sinatra::Hancock::Defaults::Helpers)
        app.set :sessions, true
        app.get '/' do
          ensure_authenticated
          @consumers = ::Hancock::Consumer.visible
          @consumers += ::Hancock::Consumer.internal if session_user.internal?
          haml landing_page
        end
      end
    end
  end
  register Hancock::Defaults
end
