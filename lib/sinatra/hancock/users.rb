module Sinatra
  module Hancock
    module Users
      module Helpers
        def register_form
          <<-HAML
%fieldset
  %legend Enter your new password
  %form{:action => '/sso/register/#{params['token']}', :method => 'POST'}
    %label{:for => 'password'} 
      Password:
      %input{:type => 'password', :name => 'password'}
      %br
    %label{:for => 'password_confirmation'} 
      Password(Again):
      %input{:type => 'password', :name => 'password_confirmation'}
      %br
    %input{:type => 'submit', :value => 'Am I Done Yet?'}
HAML
        end
        def signup_form
          <<-HAML
%fieldset
  %legend Signup for an account
  %form{:action => '/sso/signup', :method => 'POST'}
    %label{:for => 'first_name'} 
      First Name:
      %input{:type => 'text', :name => 'first_name'}
      %br
    %label{:for => 'last_name'} 
      Last Name:
      %input{:type => 'text', :name => 'last_name'}
      %br
    %label{:for => 'email'} 
      Email:
      %input{:type => 'text', :name => 'email'}
      %br
    %input{:type => 'submit', :value => 'Signup'}
    or
    %a{:href => '/'} Cancel
HAML
        end
        def signup_confirmation(user)
          if user.save
            <<-HAML
%h3 Success!
%p Check your email and you'll see a registration link!
- if Hancock::App.environment == :development
  /
    %a{:href => absolute_url("/sso/register/#{user.access_token}")} Clicky Clicky
HAML
          else
            <<-HAML
%h3 Signup Failed
#errors
  %p= #{user.errors.inspect}
%p
  %a{:href => '/sso/signup'} Try Again?
HAML
          end
        end

        def user_by_token(token)
          user = ::Hancock::User.first(:access_token => token)
          throw(:halt, [400, 'BadRequest']) unless user
          session['user_id'] = user.id
          user
        end
      end

      def self.registered(app)
        app.helpers Helpers

        app.get '/sso/register/:token' do
          user_by_token(params['token'])
          haml register_form
        end

        app.post '/sso/register/:token' do
          user = user_by_token(params['token'])
          user.update_attributes(:enabled => true,
                                 :access_token => nil,
                                 :password => params['password'],
                                 :password_confirmation => params['password_confirmation'])
          destination = session.delete('return_to') || '/'
          session.reject! { |key,value| key != 'user_id' }
          redirect destination
        end

        app.get '/sso/signup' do
          haml signup_form
        end

        app.post '/sso/signup' do
          user = ::Hancock::User.signup(params)
          haml signup_confirmation(user)
        end
      end
    end
  end
  register Hancock::Users
end
