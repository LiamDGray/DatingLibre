Feature:
    Users can view appropriate 404 error templates

    @errors
    Scenario: Unauthenticated can view 404 page
        Given I go to "/_error/404"
        Then I should not see "Account"
        And I should not see "Matches"
        And I should see "Page not found"
        And I should see "Please use a link above, or press the back button on your browser."
        And I should not see "Subscriptions"

    @errors
    Scenario: User can view 404 page
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And I am logged in with "user@example.com"
        And I go to "/_error/404"
        Then I should see "Account"
        And I should see "Matches"
        And I should see "Page not found"
        And I should see "Please use a link above, or press the back button on your browser."
        And I should not see "Subscriptions"

    @errors
    Scenario: Moderator can view 404 page
        Given a moderator exists with email "moderator@example.com"
        And I am logged in with "moderator@example.com"
        And I go to "/_error/404"
        Then I should not see "Account"
        And I should not see "Matches"
        And I should see "Page not found"
        And I should see "Please use a link above, or press the back button on your browser."
        And I should not see "Statistics"
        And I should see "Reports"
        And I should see "Suspensions"

    @errors
    Scenario: Admin can view 404 page
        Given an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I go to "/_error/404"
        Then I should not see "Account"
        And I should not see "Matches"
        And I should see "Page not found"
        And I should see "Please use a link above, or press the back button on your browser."
        And I should see "Statistics"
        And I should see "Reports"
        And I should see "Suspensions"