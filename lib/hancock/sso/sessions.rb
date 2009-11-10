module Hancock
  module Sessions
    def self.sessions_template(file)
      template = File.expand_path(File.dirname(__FILE__)+'/views/')
      File.read("#{template}/#{file}.haml")
    end

    def self.registered(app)
      app.helpers Helpers
      app.template(:unauthenticated) { sessions_template('unauthenticated') }

      app.get '/sso/login' do
        ensure_authenticated
        redirect '/'
      end

      app.post '/sso/login' do
        @user = ::Hancock::User.authenticate(params['email'], params['password'])
        login_as(@user)
        ensure_authenticated
        redirect session_return_to || '/'
      end

      app.get '/sso/logout' do
        session.clear
        redirect '/'
      end
    end
  end
end
