Feature: Signing in and out

  Scenario: Unsuccessful signin
    Given a user visits the signin page
    When he submits invalid signin information
    Then he should see an error message

  Scenario: Successful signin
    Given a user visits the signin page
    And the user has an account
    And the user submits valid signin information
    Then he should see his profile page
    And he should see a signout link


  Scenario: Successful signout after successful signin
    Given a user visits the signin page
    And the user has an account
    And the user submits valid signin information
    And the user clicks the logout link
    Then he should see a signin link
    And he should see the home page