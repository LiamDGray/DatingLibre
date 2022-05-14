Feature:
    A single /user/subscription URL can be provided to payment providers,
    which will redirect to the user's appropriate locale

    @account
    Scenario: I am redirected to my locale (en)
        Given the following profiles exist:
            | email            | attributes   | requirements   | city   | age |
            | user@example.com | blue, square | yellow, circle | London | 30  |
        And I am logged in with "user@example.com"
        And I am on "/user/subscription"
        Then I should be on "/en/user/subscription"

    @account
    Scenario: I am redirected to my locale (de)
        Given the following profiles exist:
            | email            | attributes   | requirements   | city   | age |
            | user@example.com | blue, square | yellow, circle | London | 30  |
        And I am logged in with "user@example.com"
        And I request the language "de"
        And I am on "/user/subscription"
        Then I should be on "/de/user/subscription"