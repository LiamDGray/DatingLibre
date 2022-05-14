Feature: As a user I can manage my subscriptions

    @subscription
    Scenario: I can view subscription signup links
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        Then I should see "Buy a subscription with Manual"

    @subscription
    Scenario: I cannot view subscription signup links if I have been suspended
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And an administrator exists with email "admin@example.com"
        And the administrator "admin@example.com" has permanently suspended "user@example.com"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        Then I should not see "Buy"

    @subscription
    Scenario: I can view my subscription on the account page
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        Then I should see "985938"
        And I should see "Active"
        And I should see next month
        And I should not see "Buy a subscription"

    @subscription
    Scenario: I can cancel my subscription but cannot buy a new subscription until cancelled subscription has expired
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And there has been a cancellation event for subscription "985938" for provider "manual"
        Then a new "cancelled" event should be created for "user@example.com"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        Then I should see "cancelled"
        And I should not see "Buy a subscription"
        And I should see "N/a"

    @subscription
    Scenario: I can cancel my subscription and buy a new subscription after the cancelled subscription has expired
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has a subscription with expiry "2020-01-01" and status "CANCELLED"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        Then I should see "cancelled"
        And I should see "Buy a subscription"
        And I should see "N/a"

    @subscription
    Scenario: I cannot view subscription links on the day of subscription expiry, when it has not been cancelled
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has a subscription with expiry "now" and status "ACTIVE"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        And I should not see "Buy a subscription"