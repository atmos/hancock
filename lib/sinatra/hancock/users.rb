module Sinatra
  module Hancock
    module Users
      def self.users_template(file)
        template = File.expand_path(File.dirname(__FILE__)+'/views/users')
        File.read("#{template}/#{file}.haml")
      end

      module Helpers
        def user_by_token(token)
          user = ::Hancock::User.first(:access_token => token)
          throw(:halt, [400, 'BadRequest']) unless user
          session['hancock_server_user_id'] = user.id
          user
        end

        def signup_email
          <<-HAML
Hello #{@user.first_name},

Thanks for signing up for #{::Hancock::App.provider_name}!  In order to 
complete your registration you will need to click on the following link.

#{@registration_url}

Thanks,
The #{::Hancock::App.provider_name} team
#{absolute_url('/')}
HAML
        end
      end

      def self.registered(app)
        app.helpers Helpers

        app.template(:signup_confirmation) { users_template('signup_confirmation') }
        app.template(:signup_form) { users_template('signup_form') }
        app.template(:register_form) { users_template('register_form') }

        app.get '/sso/register/:token' do
          user_by_token(params['token'])
          haml :register_form
        end

        app.post '/sso/register/:token' do
          user = user_by_token(params['token'])
          user.update_attributes(:enabled => true,
                                 :access_token => nil,
                                 :password => params['password'],
                                 :password_confirmation => params['password_confirmation'])
          destination = session.delete('hancock_server_return_to') || '/'
          session.reject! { |key,value| key != 'hancock_server_user_id' }
          redirect destination
        end

        app.get '/sso/signup' do
          haml :signup_form
        end

        app.post '/sso/signup' do
          @user = ::Hancock::User.signup(params)
          from = options.do_not_reply

          if @user.save
            raise ::Hancock::ConfigurationError.new("You need to define options.do_not_reply") unless from
            @registration_url = absolute_url("/sso/register/#{@user.access_token}")
            unless options.smtp.empty?
              Pony.mail(:to => @user.email, :from => from,
                        :subject => "Welcome to #{::Hancock::App.provider_name}!",
                        :body    => haml(signup_email),
                        :via => 'smtp', :smtp => options.smtp)
            end
          end
          haml :signup_confirmation
        end
      end
    end
  end
  register Hancock::Users
end
