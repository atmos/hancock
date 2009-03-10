Feature: Signing Up for an SSO Account
  In order to get users involved
  As a new user
    Scenario: signup with a get parameter to return_to
      Given I do not have a valid session on the server
      And a valid consumer and user exists
      When I request authentication returning to a consumer app
      Then I should see the login form
      When I click signup
      Then I should see the signup form
      When I signup with valid info
      Then I should receive a registration url
      When I hit the registration url and provide a password
      Then I should be redirected to the consumer app

    Scenario: signup with a get parameter to return_to
      Given I do not have a valid session on the server
      And a valid consumer and user exists
      Given I request authentication
      Then I should see the login form
      When I click signup
      Then I should see the signup form
      When I signup with valid info
      Then I should receive a registration url
      When I hit the registration url and provide a password
      Then I should be redirected to the application root
