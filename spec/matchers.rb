module Hancock
  module Matchers

    class LoginForm
      include Webrat::Methods
      include Webrat::Matchers
      def matches?(target)
        target.should have_selector("form[action='/sso/login'][method='POST']")
        target.should have_selector("form[action='/sso/login'][method='POST'] input[type='text'][name='email']")
        target.should have_selector("form[action='/sso/login'][method='POST'] input[type='password'][name='password']")
        target.should have_selector("form[action='/sso/login'][method='POST'] input[type='submit'][value='Login']")
        true
      end

      def failure_message
        puts "Expected a login form to be displayed, it wasn't"
      end
    end

    def be_a_login_form
      LoginForm.new
    end

    class SignupForm
      include Webrat::Methods
      include Webrat::Matchers
      def matches?(target)
        target.should have_selector("form[action='/sso/signup'][method='POST']")
        target.should have_selector("form[action='/sso/signup'][method='POST'] input[type='text'][name='email']")
        target.should have_selector("form[action='/sso/signup'][method='POST'] input[type='text'][name='first_name']")
        target.should have_selector("form[action='/sso/signup'][method='POST'] input[type='text'][name='last_name']")
        target.should have_selector("form[action='/sso/signup'][method='POST'] input[type='submit'][value='Signup']")
        true
      end

      def failure_message
        puts "Expected a signup form to be displayed, it wasn't"
      end
    end

    def be_a_signup_form
      SignupForm.new
    end

  end
end
