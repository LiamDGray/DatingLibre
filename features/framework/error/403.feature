Feature:
    Users can view appropriate 403 templates

    @errors
    Scenario: Unauthenticated can view 403 page
        Given I go to "/_error/403"
        Then I should not see "Account"
        And I should not see "Matches"
        And I should see "Forbidden"
        And I should see "Your user is not permitted access to this page."
        And I should not see "Subscriptions"

    @errors
    Scenario: User can view 403 page
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And I am logged in with "user@example.com"
        And I go to "/_error/403"
        Then I should see "Account"
        And I should see "Matches"
        And I should see "Forbidden"
        And I should see "Your user is not permitted access to this page."
        And I should not see "Subscriptions"

    @errors
    Scenario: Moderator can view 403 page
        Given a moderator exists with email "moderator@example.com"
        And I am logged in with "moderator@example.com"
        And I go to "/_error/403"
        Then I should not see "Account"
        And I should not see "Matches"
        And I should see "Forbidden"
        And I should see "Your user is not permitted access to this page."
        And I should not see "Statistics"
        And I should see "Reports"
        And I should see "Suspensions"

    @errors
    Scenario: Admin can view 403 page
        Given an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I go to "/_error/403"
        Then I should not see "Account"
        And I should not see "Matches"
        And I should see "Forbidden"
        And I should see "Your user is not permitted access to this page."
        And I should see "Statistics"
        And I should see "Reports"
        And I should see "Suspensions"