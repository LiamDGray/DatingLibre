Feature:
    I can view the contact page

    @account
    Scenario: I successfully delete my account
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And I am logged in with "user@example.com"
        When I go to "/en/user/contact"
        Then I should see "admin@datinglibre.com"