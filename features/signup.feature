Feature: Signing Up for an SSO Account
  In order to get users involved
  As a new user
  Background:
    Given a valid consumer exists
    And I am a new user to the SSO provider

  Scenario: signing up as a redirect from a consumer
    When I request authentication returning to the consumer app
    Then I should be prompted to login
    When I signup for an account
    Then I am redirected to the consumer app

  Scenario: signing up
    When I request the login page
    Then I should be prompted to login
    When I signup for an account
    Then I can login as the new user
