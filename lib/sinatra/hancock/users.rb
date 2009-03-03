module Sinatra
  module Hancock
    module Users
      module Helpers
      end

      def self.registered(app)
        app.send(:include, Sinatra::Hancock::Users::Helpers)
        app.post '/sso/register/:token' do
          @user = ::Hancock::User.first(:access_token => params['token'])
          raise ArgumentError unless @user
          @user.update_attributes(:password => params['password'],
                                  :password_confirmation => params['password_confirmation'])
          session[:user_id] = @user.id
          redirect '/'
        end
        app.get '/sso/register/:token' do
          @user = ::Hancock::User.first(:access_token => params['token'])
          raise not_found unless @user

          haml(<<-HTML
%form{:action => '/sso/register/#{params['token']}', :method => 'POST'}
  %label{:for => 'password'} 
    Password:
    %input{:type => 'password', :name => 'password'}
    %br
  %label{:for => 'password'} 
    Password(Again):
    %input{:type => 'password', :name => 'password_confirmation'}
    %br
  %input{:type => 'submit', :value => 'Am I Done Yet?'}
HTML
          )
        end
        app.get '/sso/signup' do
          haml(<<-HTML
%form{:action => '/sso/signup', :method => 'POST'}
  %label{:for => 'email'} 
    Email:
    %input{:type => 'text', :name => 'email'}
    %br
  %label{:for => 'first_name'} 
    First Name:
    %input{:type => 'text', :name => 'first_name'}
    %br
  %label{:for => 'last_name'} 
    Last Name:
    %input{:type => 'text', :name => 'last_name'}
    %br
  %input{:type => 'submit', :value => 'Signup'}
HTML
          )
        end

        app.post '/sso/signup' do
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
  %a{:href => absolute_url("/sso/register/#{@user.access_token}")} Clicky Clicky
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
