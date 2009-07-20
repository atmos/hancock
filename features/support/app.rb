class MySweetSSOServer < Hancock::App
  set :provider_name, 'Example SSO Provider'
  set :do_not_reply, 'sso@example.com'
  set :smtp, { }
  set :environment, 'production'

  get '/' do
    redirect '/sso/login' unless session_user
    erb "<h2>Hello <%= session_user.full_name %><!-- <%= session.inspect %>"
  end
end
