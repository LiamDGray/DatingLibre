Feature:
    As a user I can view translations

    @translation
    Scenario: I can view a translation
        Given the following profiles exist:
            | email            | city   | age |
            | user@example.com | London | 30  |
        And I request the language "de"
        And I am on "/"
        Then I should be on "/de/login"
        Then I should see "Anmelden"

    @translation
    Scenario: I am defaulted to default translation if language not supported
        Given the following profiles exist:
            | email            | city   | age |
            | user@example.com | London | 30  |
        And I request the language "eo"
        And I am on "/"
        Then I should be on "/en/login"
        Then I should see "Log in"