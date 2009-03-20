Feature: Logging In to an SSO Account
  In order to authenticate existing users
  As an existing user
    Scenario: logging in
      Given I am not logged in on the sso provider
      And a valid consumer and user exists
      When I request the landing page
      Then I should see the login form
      When I login
      Then I should see a list of consumers
    Scenario: logging in as a redirect from a consumer
      Given I am not logged in on the sso provider
      And a valid consumer and user exists
      When I request authentication returning to the consumer app
      Then I should see the login form
      When I login
      Then I should be redirected to the consumer app to start the handshake
    Scenario: logging in
      Given I am not logged in on the sso provider
      And a valid consumer and user exists
      When I request authentication
      Then I should see the login form
      When I login
      Then I should be redirected to the sso provider root on login
    Scenario: logging in with a bad return_to cookie set
      Given I am logged in on the sso provider
      And a valid consumer and user exists
      When I request the login page
      Then I should be redirected to the sso provider root
