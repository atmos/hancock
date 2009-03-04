module Sinatra
  module Hancock
    module Sessions
      module Helpers
        def session_user
          session[:user_id].nil? ? nil : ::Hancock::User.get(session[:user_id])
        end

        def ensure_authenticated
          login_view = <<-HAML
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
HAML
          if trust_root = params['return_to']
            if ::Hancock::Consumer.allowed?(trust_root)
              if session_user
                redirect "#{trust_root}?id=#{session_user.id}"
              else
                session['return_to'] = trust_root
              end
            else
              throw(:halt, [403, 'Forbidden'])
            end
          end
          throw(:halt, [401, haml(login_view)]) unless session_user
        end
      end

      def self.registered(app)
        app.send(:include, Sinatra::Hancock::Sessions::Helpers)
        app.get '/sso/login' do
          ensure_authenticated
        end
        app.post '/sso/login' do
          @user = ::Hancock::User.authenticate(params['email'], params['password'])
          if @user
            session[:user_id] = @user.id
          end
          ensure_authenticated
          redirect '/'
        end

        app.get '/sso/logout' do
          session.clear
          redirect '/'
        end
      end
    end
  end
  register Hancock::Sessions
end
