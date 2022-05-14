Feature: Administrators can view user subscription events

    @subscription
    Scenario: An administrator can view the subscription event's user
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And an administrator exists with email "admin@example.com"
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/subscription/events"
        And I check "New sale"
        And I press "Filter"
        Then I should see "985938"
        And I follow "User"
        Then I should see "user@example.com"
        And I should see "985938"
        And I should see "Manual"
        And I should see "New sale"