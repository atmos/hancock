class MySweetSSOServer < Hancock::SSO::App
  get '/' do
    redirect '/sso/login' unless session_user
    erb "<h3>Hello <%= session_user.full_name %></h3><!-- <%= session.inspect %>"
  end
end
