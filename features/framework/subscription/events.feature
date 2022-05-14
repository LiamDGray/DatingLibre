Feature: Subscription events modify the subscription

    @subscription
    Scenario: A new subscription sale is persisted as an event
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        Then a new "new_sale" event should be created for "user@example.com"
        And a new "manual" subscription is created for "user@example.com" with provider subscription ID "985938"

    @subscription
    Scenario: A new subscription failure is persisted as an event
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has failed to buy a new subscription with provider "manual"
        Then a new "new_sale_failure" event should be created for "user@example.com"

    @subscription
    Scenario: A renewal with a missing subscription is raised as an event
        Given an administrator exists with email "admin@example.com"
        And there has been a renewal event for the missing subscription "123459876"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/subscription/events"
        And I check "Subscription not found"
        Then I should see "Subscription not found"
        And I press "Filter"
        And I should see "renewal"
        And I should see "subscriptionId"
        And I should see "123459876"

    @subscription
    Scenario: A subscription can fail renewal
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And there has been a failed renewal for subscription "985938" for provider "manual" with next retry date "2020-08-23"
        Then a new "renewal_failure" event should be created for "user@example.com"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        And I should see "Renewal failure"
        And I should see "August 23, 2020"

    @subscription
    Scenario: The subscription can be marked as a chargeback
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And there has been a chargeback event for subscription "985938" for provider "manual"
        Then a new "chargeback" event should be created for "user@example.com"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        Then I should see "Chargeback"
        And I should see "N/a"

    @subscription
    Scenario: I can refund the subscription
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And there has been a refund event for subscription "985938" for provider "manual"
        Then a new "refunded" event should be created for "user@example.com"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        Then I should see "Refund"
        And I should see "N/a"

    @subscription
    Scenario: I can change billing renewal date
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And there has been a billing date change event for "985938" for provider "manual" to "2021-02-01"
        Then a new "billing_date_change" event should be created for "user@example.com"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        Then I should see "Active"
        And I should see "February 1, 2021"

    @subscription
    Scenario: A subscription can expire
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And there has been an expiration event for "985938" for provider "manual"
        Then a new "expired" event should be created for "user@example.com"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        Then I should see "Expired"

    @subscription
    Scenario: a missing user parameter error can be raised
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When a missing user parameter error event is raised for "manual" for "user@example.com"
        Then a "missing_user_parameter" subscription event should be created

    @subscription
    Scenario: an unrecognized event error can be raised
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When an unrecognized event error event is raised for "manual" for "user@example.com"
        Then a "unrecognized_event" subscription event should be created

    @subscription
    Scenario: I cannot buy a subscription if I already have a subscription
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        When the user "user@example.com" has bought another new subscription from "manual" that has ID "985938"
        # Exception is asserted in previous step
        Then a "duplicate" subscription event should be created

    @subscription
    Scenario: A new subscription without a user will log an error and throw an exception
        When a missing user has bought a new subscription
        Then a "user_not_found" subscription event should be created

    @subscription
    Scenario: A subscription can renew
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And there has been a renewal event for subscription "985938"
        Then a new "renewal" event should be created for "user@example.com"
        And I am logged in with "user@example.com"
        And I am on "/en/user/subscription"
        And I should see "Active"
        And I should see next month
        And I should not see "Buy a subscription"

