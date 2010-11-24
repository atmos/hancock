module Hancock
  class UserConfigurationError < StandardError; end

  class AuthenticationUser
    def self.authenticated?(password)
      raise UserConfigurationError, "You need to setup a Hancock::User authentication class"
    end
  end

  class User
    def self.authentication_class=(klass)
      @authentication_class = klass
    end

    def self.authentication_class
      @authentication_class ||= AuthenticationUser
    end

    def self.authenticated?(username, password)
      authentication_class.authenticated?(username, password)
    end
  end
end
