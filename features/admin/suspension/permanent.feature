Feature:
    As a moderator I can queue a user for permanent suspension

    @suspension
    Scenario: An administrator can permanently suspend a profile
        Given the following profiles exist:
            | email                 |
            | reporter@example.com  |
            | suspended@example.com |
        And the user "reporter@example.com" has reported "suspended@example.com"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I follow "Reports"
        Then I follow "suspended"
        And I follow "Permanently suspend"
        And I check "Abusive messages"
        And I press "Confirm"
        Then I should see "Profile has been permanently suspended"
        And the user "suspended@example.com" should receive a permanent suspension email with "Abusive messages"
        And I follow "profile-menu-suspensions"
        Then I should see "Open"

    @suspension
    Scenario: A permanent suspension by an administrator overrides a previous suspension
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And a moderator exists with email "moderator@example.com"
        And the moderator "moderator@example.com" has suspended "user@example.com" for "spam" for "72" hours
        And an administrator exists with email "admin@example.com"
        And the administrator "admin@example.com" has permanently suspended "user@example.com"
        Then the user "user@example.com" should receive a permanent suspension email with "Spam"

    @suspension
    Scenario: An administrator can confirm a permanent suspension
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And a moderator exists with email "moderator@example.com"
        And the moderator "moderator@example.com" has entered "user@example.com" into the permanent suspension queue
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I follow "Suspensions"
        And I follow "Unconfirmed permanent suspensions"
        Then I should see "user"
        And I should see "Spam"
        And I follow "user"
        And I follow "Permanently suspend"
        And I check "Abusive messages"
        And I press "Confirm"
        Then I should see "Profile has been permanently suspended"
        And I follow "profile-menu-suspensions"
        Then I should see "Spam"
        Then I should see "Abusive messages"
        And I follow "Permanently suspend"
        Then I should see "Permanently suspended"
        And I follow "Logout"
        And I am logged in with "user@example.com"
        Then I should see "Suspended"

    @suspension
    Scenario: An administrator can close a permanent suspension
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And a moderator exists with email "moderator@example.com"
        And the moderator "moderator@example.com" has entered "user@example.com" into the permanent suspension queue
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I follow "Suspensions"
        And I follow "Unconfirmed permanent suspensions"
        And I follow "user"
        And I follow "profile-menu-suspensions"
        And I follow "Close"
        And I press "Close"
        Then I should see "Closed"
        And I follow "Suspensions"
        And I follow "Unconfirmed permanent suspensions"
        Then I should not see "newuser"

    @suspension
    Scenario: a permanent suspension cancels the subscription
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And the user "user@example.com" has a "manual" subscription with ID "985938"
        And an administrator exists with email "admin@example.com"
        And the administrator "admin@example.com" has permanently suspended "user@example.com"
        Then the subscription for "user@example.com" is cancelled
        And I log in using email "user@example.com"
        And I am on "/en/user/profile"
        Then I should see "your profile has been permanently suspended for the reasons below"
        And I should see "Your subscription, if it exists, has been cancelled."
        And I should see "Spam"
        And I am on "/en/user/subscription"
        And I should see "Cancelled"
        And I should see "Your profile has been permanently suspended for the reasons below"
        And I should see "Your subscription, if it exists, has been cancelled"
        Then I should not see "Buy a subscription"