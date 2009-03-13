Feature: Authenticating Against the SSO Provider
  In order to authenticate existing users on a consumer via openid
    Scenario: OpenID Mode CheckIDSetup
    Scenario: OpenID Mode Immediate
      Given a valid consumer and user exists
      And I am logged in on the sso provider
      And a valid consumer exists
      When I request the sso page with a checkid mode of immediate
      Then I should be redirected to the consumer app with openid params
    Scenario: OpenID Mode Associate
      Given a valid consumer and user exists
      And I am logged in on the sso provider
      And a valid consumer exists
      When I request the sso page with a checkid mode of associate
      Then I should receive an associate response from the sso server
