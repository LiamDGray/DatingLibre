Feature:
    Users can view appropriate 500 templates

    @errors
    Scenario: Unauthenticated can view 500 page
        Given I go to "/_error/500"
        Then I should not see "Account"
        And I should not see "Matches"
        And I should see "Internal server error"
        And I should see "The error has been logged."
        And I should not see "Subscriptions"

    @errors
    Scenario: User can view 403 page
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And I am logged in with "user@example.com"
        And I go to "/_error/500"
        Then I should see "Account"
        And I should see "Matches"
        And I should see "Internal server error"
        And I should see "The error has been logged."
        And I should not see "Subscriptions"

    @errors
    Scenario: Moderator can view 403 page
        Given a moderator exists with email "moderator@example.com"
        And I am logged in with "moderator@example.com"
        And I go to "/_error/500"
        Then I should not see "Account"
        And I should not see "Matches"
        And I should see "Internal server error"
        And I should see "The error has been logged."
        And I should not see "Statistics"
        And I should see "Reports"
        And I should see "Suspensions"

    @errors
    Scenario: Admin can view 403 page
        Given an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I go to "/_error/500"
        Then I should not see "Account"
        And I should not see "Matches"
        And I should see "Internal server error"
        And I should see "The error has been logged."
        And I should see "Statistics"
        And I should see "Reports"
        And I should see "Suspensions"