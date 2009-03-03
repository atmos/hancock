module Sinatra
  module Hancock
    module Users
      module Helpers
      end

      def self.registered(app)
        app.send(:include, Sinatra::Hancock::Users::Helpers)
        app.get '/users' do
          'ZOMG'
        end

        app.post '/users/login' do
          @user = ::Hancock::User.authenticate(params['email'], params['password'])
          if @user
            session[:user_id] = @user.id
          end
          ensure_authenticated
          redirect '/'
        end

        app.get '/users/logout' do
          session.clear
          redirect '/'
        end

        app.get '/users/signup' do
          haml :signup
        end

        app.post '/users/signup' do
          seed = Guid.new.to_s
          @user = ::Hancock::User.new(:email                 => params['email'],
                                      :first_name            => params['first_name'],
                                      :last_name             => params['last_name'],
                                      :password              => Digest::SHA1.hexdigest(seed),
                                      :password_confirmation => Digest::SHA1.hexdigest(seed))
          haml(if @user.save
            <<-HTML
%h3 Success!
%p Check your email and you'll see a registration link!
/
  %a{:href => absolute_url("/users/register/#{@user.access_token}")} Clicky Clicky
HTML
          else
            <<-HTML
%h3 Signup Failed
#errors
  %p= @user.errors.inspect
%p
  %a{:href => '/users/signup'} Try Again?
HTML
          end)
        end
      end
    end
  end
  register Hancock::Users
end
