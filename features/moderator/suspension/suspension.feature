Feature:
    As a moderator or admin I can suspend a user

    @suspension
    Scenario: A moderator can suspend a user
        Given the following profiles exist:
            | email                 | city   | age |
            | reporter@example.com  | London | 30  |
            | suspended@example.com | London | 30  |
        And the user "reporter@example.com" has reported "suspended@example.com"
        And a moderator exists with email "moderator@example.com"
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/reports"
        And I follow "suspended"
        And I follow "profile-menu-suspensions"
        Then I should see "Abusive messages"
        Then I should see "No suspensions"
        And I check "Spam"
        And I press "Suspend"
        Then the user "suspended@example.com" should receive a suspension email for "Spam" for "24" hours
        Then I should see "User suspended"

    @suspension
    Scenario: When a moderator creates another suspension, the previous suspension will be closed
        Given the following profiles exist:
            | email                 | city   | age |
            | suspended@example.com | London | 30  |
        And a moderator exists with email "moderator@example.com"
        And the moderator "moderator@example.com" has suspended "suspended@example.com" for "spam" for "72" hours
        And the moderator "moderator@example.com" has suspended "suspended@example.com" for "spam" for "72" hours
        Then only one open suspension should exist for "suspended@example.com"

    @suspension
    Scenario: A moderator can view expired suspensions
        Given the following profiles exist:
            | email                 | city   | age |
            | suspended@example.com | London | 30  |
        And a moderator exists with email "moderator@example.com"
        And the moderator "moderator@example.com" has suspended "suspended@example.com" for "spam" for "72" hours
        When "73" hours has elapsed for the suspension under "suspended@example.com"
        And I log in using email "moderator@example.com"
        And I am on "/en/moderator/suspensions"
        Then I should see "suspended"
        And I follow "suspended"
        Then I should see "suspended"
        And I should see "London"

    @suspension
    Scenario: A moderator does not view suspensions that have not expired
        Given the following profiles exist:
            | email                 | city   | age |
            | suspended@example.com | London | 30  |
        And a moderator exists with email "moderator@example.com"
        And the moderator "moderator@example.com" has suspended "suspended@example.com" for "spam" for "72" hours
        And I log in using email "moderator@example.com"
        And I am on "/en/moderator/suspensions"
        Then I should not see "suspended"

    @suspension
    Scenario: A moderator can close a suspension
        Given the following profiles exist:
            | email                 | city   | age |
            | suspended@example.com | London | 30  |
        And a moderator exists with email "moderator@example.com"
        And the moderator "moderator@example.com" has suspended "suspended@example.com" for "spam" for "72" hours
        And the user "suspended@example.com" should receive a suspension email for "Spam" for "72" hours
        When "73" hours has elapsed for the suspension under "suspended@example.com"
        And I log in using email "moderator@example.com"
        And I am on "/en/moderator/suspensions"
        And I follow "suspended"
        And I follow "Close"
        Then I should see "Are you sure you want to close this suspension?"
        And I press "Close"
        Then I should see "Closed suspension"
        And I follow "Suspensions"
        Then I should not see "suspended"

    @suspension
    Scenario: A moderator can enter a user into the permanent suspension queue.
        Given the following profiles exist:
            | email                 |
            | reporter@example.com  |
            | suspended@example.com |
        And the user "reporter@example.com" has reported "suspended@example.com"
        And a moderator exists with email "moderator@example.com"
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/reports"
        And I follow "suspended"
        And I follow "Permanently suspend"
        And I should see "Are you sure you want to suspend and enter this profile into the permanent suspension queue?"
        And I check "Abusive messages"
        And I press "Confirm"
        And the user "suspended@example.com" should receive a suspension email for "Abusive messages"
        Then I should see "Profile has been entered into queue for permanent suspension"
        And I should not see "Are you sure you want to suspend and enter this profile into the permanent suspension queue?"
        And I follow "profile-menu-suspensions"
        Then I should see "Permanent"
        Then I should see "Open"
        And I should see "Abusive messages"
        And I follow "Logout"
        And I am logged in with "suspended@example.com"
        Then I should see "The suspension will be reviewed."
        And I follow "Edit"
        Then I should see "The suspension will be reviewed."

    @suspension
    Scenario: The respective moderator names should be displayed next to each closed suspension
        Given the following profiles exist:
            | email                 | city   | age |
            | suspended@example.com | London | 30  |
        And a moderator exists with email "moderator1@example.com"
        And a moderator exists with email "moderator2@example.com"
        And the moderator "moderator1@example.com" has suspended "suspended@example.com" for "spam" for "72" hours
        When "73" hours has elapsed for the suspension under "suspended@example.com"
        And I log in using email "moderator1@example.com"
        And I am on "/en/moderator/suspensions"
        And I follow "suspended"
        And I follow "Close"
        And I press "Close"
        And I follow "Logout"
        And the moderator "moderator2@example.com" has suspended "suspended@example.com" for "spam" for "72" hours
        When "73" hours has elapsed for the suspension under "suspended@example.com"
        And I log in using email "moderator2@example.com"
        And I am on "/en/moderator/suspensions"
        And I follow "suspended"
        And I follow "Close"
        And I press "Close"
        Then I should see "moderator1@example.com"
        And I should see "moderator2@example.com"



