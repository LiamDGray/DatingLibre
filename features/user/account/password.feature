Feature:
    As a user
    I want to reset my password

    @security
    Scenario: I can reset my password
        Given the following profiles exist:
            | email            | city   | age |
            | user@example.com | London | 30  |
        When I am on "/en/password/reset"
        And I fill in "user@example.com" for "Email"
        And I press "Submit"
        And I should see "If an account for your email exists, a password reset link has been emailed to you"
        And I should receive a password reset email to "user@example.com"
        And I click the password reset link I should see "Update password"
        And I fill in "foobar" for "Password"
        And I fill in "foobar" for "Confirm password"
        And I press "Submit"
        Then I should see "Password updated. Please login below"
        And I log in using email "user@example.com" and password "foobar"
        Then I should see "Logout"

    @security
    Scenario: I can reset my password with mixture of upper and lowercase email
        Given the following profiles exist:
            | email            | city   | age |
            | user@example.com | London | 30  |
        When I am on "/en/password/reset"
        And I fill in "user@example.com" for "Email"
        And I press "Submit"
        And I should see "If an account for your email exists, a password reset link has been emailed to you"
        And I should receive a password reset email to "user@example.com"


    @security
    Scenario: I cannot reset my email with a blank address
        Given the following profiles exist:
            | email            | city   | age |
            | user@example.com | London | 30  |
        When I am on "/en/password/reset"
        And I fill in "" for "Email"
        And I press "Submit"
        Then I should see "Please enter an email address"

    @security
    Scenario: I cannot reset my email with a blank address
        Given the following profiles exist:
            | email            | city   | age |
            | user@example.com | London | 30  |
        When I am on "/en/password/reset"
        And I fill in "invalid" for "Email"
        And I press "Submit"
        Then I should see "Please enter a valid email address"

    @security
    Scenario: I can't reset my password with incorrect secret
        Given the following profiles exist:
            | email            | city   | age |
            | user@example.com | London | 30  |
        When I am on "/en/password/reset"
        And I fill in "user@example.com" for "Email"
        And I press "Submit"
        And I should see "If an account for your email exists, a password reset link has been emailed to you"
        And I should receive a password reset email to "user@example.com"
        And I click the password reset link with the incorrect secret I should see "Update password"
        And I fill in "foobar" for "Password"
        And I fill in "foobar" for "Confirm password"
        And I press "Submit"
        Then I should see "Password update failed"
        And I log in using email "user@example.com" and password "foobar"
        Then I should be on "/en/login"

