module Sinatra
  module Hancock
    module TestApp
      module Helpers
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
        app.helpers Helpers
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
  ::Hancock::App.register(Hancock::TestApp)
end
