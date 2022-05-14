Feature:
    As an administrator I can view unlinked user subscriptions

    @subscription
    Scenario: I can view unlinked subscriptions
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
        And I am on "/en/admin/user/subscriptions/unlinked"
        Then I should see "985938"
        And I follow "User subscription search"
        And I select "Manual" from "subscription_search_form_provider"
        And I fill in "985938" for "subscription_search_form_providerSubscriptionId"
        And I press "Search"
        And I follow "Link user"
        And I fill in "user@example.com" for "email_form_email"
        And I press "Confirm"
        Then I should see "Successfully linked user to subscription"
        And I am on "/en/admin/user/subscriptions/unlinked"
        Then I should see "No unlinked subscriptions"
