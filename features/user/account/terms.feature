Feature:
    I can view the terms page

    @account
    Scenario: I successfully delete my account
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And I am logged in with "user@example.com"
        When I go to "/en/user/terms"
        Then I should see "This site is provided solely for demonstration purposes of Dating Libre"