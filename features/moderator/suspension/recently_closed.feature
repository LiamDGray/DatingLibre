Feature:
    As a moderator or admin I can view recently suspended profiles

    @suspension
    Scenario: A moderator can suspend a user
        Given the following profiles exist:
            | email                 | city   | age |
            | suspended@example.com | London | 30  |
        And a moderator exists with email "moderator@example.com"
        And an administrator exists with email "admin@example.com"
        And the moderator "moderator@example.com" has suspended "suspended@example.com" for "spam" for "72" hours
        And 73 hours has elapsed for the suspension under "suspended@example.com"
        And I am logged in with "moderator@example.com"
        And I follow "Suspensions"
        And I follow "suspended"
        And I follow "gherkin-close-suspension"
        And I press "Close"
        And I follow "Suspensions"
        And I follow "Recently closed"
        Then I should see "suspended"
        And I should see "Spam"



