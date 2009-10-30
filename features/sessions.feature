Feature: Logging In to an SSO Account
  In order to authenticate existing users
  As an existing user
  Background:
    Given a valid consumer and user exists

  Scenario: I am not logged in and I (GET /)
    When I request the landing page
    Then I should be prompted to login
    When I login
    Then I am greeted

  Scenario: I am not logged in and redirected from a consumer
    When I request authentication returning to the consumer app
    Then I should be prompted to login
    When I login
    Then I should be redirected to the consumer app to start the handshake

  Scenario: I am not logged in and I (GET /sso/login)
    When I request the login page
    Then I should be prompted to login
    When I login
    Then I am greeted

  Scenario: I am not logged in and redirected from an unauthorized consumer
    Then I login
    When I request the login page
    Then I am greeted
