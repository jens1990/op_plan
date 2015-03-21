Feature: Navigation between static pages

  Scenario: From home page to help pag
    Given a user visits the home page
    When he navigates to the help page
    Then he should see the help page

  Scenario: From help page to about page
    Given a user visits the help page
    When he navigates to the about page
        Then he should see the about page

