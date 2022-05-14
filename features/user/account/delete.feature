Feature:
    I can close my account

    @account
    Scenario: I successfully delete my account
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And the user "user@example.com" has uploaded a profile image
        And I am logged in with "user@example.com"
        When I go to "/en/user/delete"
        Then I should see "Confirm your password below to permanently delete your account"
        And I fill in "delete_account_form_password" with "password"
        And I press "Permanently delete my account"
        Then I should be on "/en/login"
        And there should be a user archive for "user@example.com"

    @account
    Scenario: I cannot delete my account without confirming the password
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And the user "user@example.com" has uploaded a profile image
        And I am logged in with "user@example.com"
        When I go to "/en/user/delete"
        Then I should see "Confirm your password below to permanently delete your account"
        And I fill in "delete_account_form_password" with "pass"
        And I press "Permanently delete my account"
        Then I should see "Incorrect password"

    @account
    Scenario: I cannot delete my account if I have a active subscription
        Given the following profiles exist:
            | email            |
            | user@example.com |
        And the user "user@example.com" has a subscription
        And I am logged in with "user@example.com"
        When I go to "/en/user/delete"
        Then I should see "You must cancel your subscription before you can delete your account"