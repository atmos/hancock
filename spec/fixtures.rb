Hancock::User.fix {{
  :enabled               => true,
  :email                 => /\w+@\w+.\w{2,3}/.gen.downcase,
  :first_name            => /\w+/.gen.capitalize,
  :last_name             => /\w+/.gen.capitalize,
  :password              => (pass = /\w+/.gen.downcase),
  :password_confirmation => pass,
  :salt                  => (salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--email--")),
  :crypted_password      => Hancock::User.encrypt(pass, salt)
}}

Hancock::Consumer.fix(:internal) {{
  :url      => %r!http://(\w+).example.org/login!.gen.downcase,
  :label    => /(\w+) (\w+)/.gen,
  :internal => true
}}

Hancock::Consumer.fix(:visible_to_all) {{
  :url      => %r!http://(\w+).consumerapp.com/login!.gen.downcase,
  :label    => /(\w+) (\w+)/.gen,
  :internal => false
}}

Hancock::Consumer.fix(:hidden) {{
  :url      => 'http://localhost:9292/login',
  :internal => false
}}
