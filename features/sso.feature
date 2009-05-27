Feature: Authenticating Against the SSO Provider
  In order to authenticate existing users on a consumer via openid
    Scenario: SSO Server should be an OpenID Identity Provider
      When I request the OpenID Identity Provider Page
      Then I should receive a yadis document from the sso server

    Scenario: OpenID Mode CheckIDSetup
      Given a valid consumer and user exists
      And I am logged in on the sso provider
      When I request the sso page with a checkid mode of checkIDSetup
      Then I should be redirected to the consumer app with openid params
    Scenario: OpenID Mode CheckIDSetup
      Given a valid consumer and user exists
      And I am logged in on the sso provider
      When I request the sso page with a checkid mode of checkIDSetup for another users's page
      Then I should not be redirected to the consumer app with openid params
    Scenario: OpenID Mode CheckIDSetup unauthenticated
      Given a valid consumer and user exists
      When I request the sso page with a checkid mode of checkIDSetup
      Then I should see the login form

    Scenario: OpenID Mode Immediate
      Given a valid consumer and user exists
      And I am logged in on the sso provider
      When I request the sso page with a checkid mode of immediate
      Then I should be redirected to the consumer app with openid params
    Scenario: OpenID Mode Immediate unauthenticated
      Given a valid consumer and user exists
      When I request the sso page with a checkid mode of immediate
      Then I should see the login form

    Scenario: OpenID Mode Associate
      Given a valid consumer and user exists
      When I request the sso page with a checkid mode of associate
      Then I should receive an associate response from the sso server
