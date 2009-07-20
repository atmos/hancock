Feature: Authenticating Against the SSO Provider
  In order to authenticate existing users on a consumer via openid
    Scenario: OpenID Mode CheckIDSetup
      Given a valid consumer and user exists
      And I am logged in on the sso provider
      When I request the sso page with a checkid mode of checkIDSetup
      Then I should be redirected to the consumer app with openid params
    Scenario: OpenID Mode CheckIDSetup unauthenticated
      Given a valid consumer and user exists
      When I request the sso page with a checkid mode of checkIDSetup
      Then I should be prompted to login

    Scenario: OpenID Mode Immediate
      Given a valid consumer and user exists
      And I am logged in on the sso provider
      When I request the sso page with a checkid mode of immediate
      Then I should be redirected to the consumer app with openid params
    Scenario: OpenID Mode Immediate unauthenticated
      Given a valid consumer and user exists
      When I request the sso page with a checkid mode of immediate
      Then I should be prompted to login

    Scenario: OpenID Mode Associate
      Given a valid consumer and user exists
      When I request the sso page with a checkid mode of associate
      Then I should receive an associate response from the sso server
