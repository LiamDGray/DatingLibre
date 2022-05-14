Feature:
    A user loses access to site features on suspension

    @suspension
    Scenario: A user loses access to the site when they are suspended
        Given the following profiles exist:
            | email                 | city   | age |
            | suspended@example.com | London | 30  |
            | user@example.com      | London | 30  |
        And the user "suspended@example.com" has a subscription
        And the user "suspended@example.com" sends the message "Hello" to "user@example.com"
        And a moderator exists with email "moderator@example.com"
        And the moderator "moderator@example.com" has suspended "suspended@example.com" for "spam" for "72" hours
        Then the user "suspended@example.com" should receive a suspension email for "Spam" for "72" hours
        And I log in using email "user@example.com"
        And I am on "/en/user/matches"
        And I follow "suspended"
        Then I should see "suspended"
        And I should not see "message_form"
        And I follow "Logout"
        And I log in using email "suspended@example.com"
        And I am on "/en/user/profile"
        Then I should see "your profile has been suspended for the reasons below. The suspension will be queued for review after 72 hours."
        And I am on "/en/user/profile/search"
        Then I should see "your profile has been suspended for the reasons below. The suspension will be queued for review after 72 hours."
        And I am on "/en/user/matches"
        And I follow "user"
        Then I should see "your profile has been suspended for the reasons below. The suspension will be queued for review after 72 hours."

    @suspension
    Scenario: A user with a permanent suspension cannot change their profile image
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And an administrator exists with email "admin@example.com"
        And the administrator "admin@example.com" has permanently suspended "user@example.com"
        And I am logged in with "user@example.com"
        And I am on "/en/user/profile/image"
        Then I should see "your profile has been permanently suspended for the reasons below"