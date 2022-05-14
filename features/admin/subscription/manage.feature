Feature:
    As an administrator I can manage subscriptions

    @subscription
    Scenario: I can search for and view a user subscription
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/user/subscription/search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        Then I should see "985938"
        And I should see "Manual"
        And I follow "User"
        Then I should see "985938"

    @subscription
    Scenario: I can search for and view a provider subscription
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/provider/subscription/search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        Then I should see "Search user subscriptions to display status of manual subscriptions"

    @subscription
    Scenario: I can cancel a provider subscription
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/provider/subscription/search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        Then I should see "Search user subscriptions to display status of manual subscriptions"
        And I follow "Cancel"
        And I fill in "985938" for "confirm_subscription_form_providerSubscriptionId_first"
        And I press "Confirm"
        Then I should see "Posted cancellation event"
        And I am on "/en/admin/user/subscription/search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        Then I should see "Cancelled"
        And I follow "Subscription Events"
        And I check "Cancelled"
        And I press "Filter"
        Then I should see "985938"

    @subscription
    Scenario: I can't cancel a provider subscription if I don't confirm the provider subscription ID
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/provider/subscription/search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        Then I should see "Search user subscriptions to display status of manual subscriptions"
        And I follow "Cancel"
        And I fill in "123" for "confirm_subscription_form_providerSubscriptionId_first"
        And I press "Confirm"
        Then I should see "This value is not valid."

    @subscription
    Scenario: I can refund a provider subscription
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/provider/subscription/search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        Then I should see "Search user subscriptions to display status of manual subscriptions"
        And I follow "Refund"
        And I fill in "985938" for "confirm_subscription_form_providerSubscriptionId_first"
        And I press "Confirm"
        Then I should see "Posted refund event"

    @subscription
    Scenario: I can't refund a provider subscription if I don't confirm the provider subscription ID
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/provider/subscription/search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        Then I should see "Search user subscriptions to display status of manual subscriptions"
        And I follow "Refund"
        And I fill in "123" for "confirm_subscription_form_providerSubscriptionId_first"
        And I press "Confirm"
        Then I should see "This value is not valid"

    @subscription
    Scenario: I can unlink a subscription and link it to a different user
        Given the following profiles exist:
            | email                    |
            | user@example.com         |
            | another_user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/user/subscription/search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        And I follow "Unlink user"
        And I press "Unlink user"
        And I follow "Link user"
        And I fill in "another_user@example.com" for "email_form_email"
        And I press "Confirm"
        Then I should see "Successfully linked user to subscription"
        And I follow "User"
        Then I should see "another_user@example.com"

    @subscriptiona
    Scenario: I can delete a user subscription
        Given the following profiles exist:
            | email                    |
            | user@example.com         |
            | another_user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/user/subscription/search"
        Then I should see "No results"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        And I follow "Delete"
        And I press "Delete"
        Then I should be on "/en/admin/user/subscription/search"
        And I should see "User subscription deleted"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        Then I should see "No results"

    @subscription
    Scenario: I am notified when failure to link subscription
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/user/subscription/search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        And I follow "Unlink user"
        And I press "Unlink user"
        And I follow "Link user"
        And I fill in "another_user@example.com" for "email_form_email"
        And I press "Confirm"
        Then I should see "Could not link user to subscription"

   @subscription
   Scenario: I can create a manual user subscription
       Given the following profiles exist:
           | email            |
           | user@example.com |
       And an administrator exists with email "admin@example.com"
       And I am logged in with "admin@example.com"
       And I am on "/en/admin/search/user"
       And I fill in "user@example.com" for "search_term_form_term"
       And I press "Search"
       And I follow "user@example.com"
       And I follow "Subscription"
       Then I should see "No subscriptions"
       And I select "Manual" from "subscription_form_provider"
       And I select "2030" from "subscription_form_renewalDate_year"
       And I select "6" from "subscription_form_renewalDate_month"
       And I select "6" from "subscription_form_renewalDate_day"
       And I select "2030" from "subscription_form_expiryDate_year"
       And I select "6" from "subscription_form_expiryDate_month"
       And I select "6" from "subscription_form_expiryDate_day"
       And I press "Submit"
       Then I should see "Manual"
       And I should see "N/a"
       And I should see "Active"

   @subscription
   Scenario: I cannot create a duplicate manual subscription
       Given the following profiles exist:
           | email             |
           | user1@example.com |
           | user2@example.com |
       And the user "user1@example.com" has bought a new subscription from "manual" that has ID "987123"
       And an administrator exists with email "admin@example.com"
       And I am logged in with "admin@example.com"
       And I am on "/en/admin/search/user"
       And I fill in "user2@example.com" for "search_term_form_term"
       And I press "Search"
       And I follow "user2@example.com"
       And I follow "Subscription"
       Then I should see "No subscriptions"
       And I select "Manual" from "subscription_form_provider"
       And I fill in "987123" for "subscription_form_providerSubscriptionId"
       And I select "2030" from "subscription_form_renewalDate_year"
       And I select "6" from "subscription_form_renewalDate_month"
       And I select "6" from "subscription_form_renewalDate_day"
       And I select "2030" from "subscription_form_expiryDate_year"
       And I select "6" from "subscription_form_expiryDate_month"
       And I select "6" from "subscription_form_expiryDate_day"
       And I press "Submit"
       Then I should see "Subscription already exists. Use unlink and link subscription to transfer subscription to this user"

    @subscription
    Scenario: I can retrieve expired manual subscriptions
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When the user "user@example.com" has a subscription with expiry "2020-01-01" and status "ACTIVE"
        Then there should be one expired manual subscription

    @subscription
    Scenario: An administrator does not see a subscription event's user if it is null
        Given an administrator exists with email "admin@example.com"
        And  a missing user has bought a new subscription
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/subscription/events"
        Then I should see "User not found"