class MySweetSSOServer < Hancock::App
  set :provider_name, 'Example SSO Provider'
  set :do_not_reply, 'sso@example.com'
  get '/' do
    redirect '/sso/login' unless session['hancock_server_user_id']
    erb "<h2>Hello <%= session_user.name %><!-- <%= session.inspect %>"
  end
end
