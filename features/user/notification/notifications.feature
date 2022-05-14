Feature:
    I change my notifications

    @account
    Scenario: I can view my notification settings
        Given the following profiles exist:
            | email            | attributes   | requirements   | city   | age |
            | user@example.com | blue, square | yellow, circle | London | 30  |
        And I am logged in with "user@example.com"
        And I go to "/en/user/notifications"
        Then I should see "Send an email I receive a new match"
        And I uncheck "user_notifications_form_newMatchNotifications"
        And I press "Update"
        Then I should see "Settings updated"
        And the account setting "newMatchNotifications" for "user@example.com" should be "false"