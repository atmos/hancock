Feature: Logging In to an SSO Account
  In order to authenticate existing users
  As an existing user
  Background:
    Given a valid consumer and user exists

  Scenario: logging in
    Given I am not logged in on the sso provider
    When I request the landing page
    Then I should be prompted to login
    When I login
    Then I should see a list of consumers

  Scenario: logging in as a redirect from a consumer
    Given I am not logged in on the sso provider
    When I request authentication returning to the consumer app
    Then I should be prompted to login
    When I login
    Then I should be redirected to the consumer app to start the handshake

  Scenario: logging in
    Given I am not logged in on the sso provider
    When I request the login page
    When I login
    Then I should see a list of consumers

  Scenario: logging in with a bad return_to cookie set
    Then I login
    When I request the login page
    Then I should see a list of consumers
