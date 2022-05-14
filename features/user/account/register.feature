Feature:
    As a user
    I want to be able to register an account

    @registration
    Scenario: I can register for an account
        When I am on "/en/register"
        And I follow "Register"
        And I check "registration_form_agreeTerms"
        And I fill in "registration_form_email" with "user@example.com"
        And I fill in "registration_form_password_first" with "password"
        And I fill in "registration_form_password_second" with "password"
        And I press "Register"
        Then I should be on "/en/login"
        And I should see "Registration successful. Please check your email to confirm your account"
        And I should receive a confirmation email to "user@example.com"
        And I click the confirmation link and see "Your account is now enabled. You can now login"

    @registration
    Scenario: I cannot login without confirming my account
        When I am on "/en/register"
        And I follow "Register"
        And I check "registration_form_agreeTerms"
        And I fill in "registration_form_email" with "user@example.com"
        And I fill in "registration_form_password_first" with "password"
        And I fill in "registration_form_password_second" with "password"
        And I press "Register"
        Then I should be on "/en/login"
        And I should see "Registration successful. Please check your email to confirm your account"
        And I log in using email "user@example.com"
        Then I should be on "/en/login"
        And I should see "Incorrect username or password"

    @registration
    Scenario: I am notified when my account confirmation is unsuccessful
        When I am on "/en/register"
        And I follow "Register"
        And I check "registration_form_agreeTerms"
        And I fill in "registration_form_email" with "user@example.com"
        And I fill in "registration_form_password_first" with "password"
        And I fill in "registration_form_password_second" with "password"
        And I press "Register"
        Then I should be on "/en/login"
        And I should see "Registration successful. Please check your email to confirm your account"
        And I should receive a confirmation email to "user@example.com"
        And I click the confirmation link with the incorrect secret and see "Could not enable your account"

    @registration
    Scenario: I can view terms and conditions
        When I am on "/en/register"
        And I follow "Read terms and conditions"
        Then I should see "demonstration"

    @registration
    Scenario: I cannot register without agreeing to the terms
        When I am on "/en/register"
        And I fill in "registration_form_email" with "user@example.com"
        And I fill in "registration_form_password_first" with "password"
        And I fill in "registration_form_password_second" with "password"
        And I press "register"
        Then I should see "Please agree to the terms and conditions"

    @registration
    Scenario: I cannot register with an invalid email address
        When I am on "/en/register"
        And I check "registration_form_agreeTerms"
        And I fill in "registration_form_email" with "userexample.com"
        And I fill in "registration_form_password_first" with "password"
        And I fill in "registration_form_password_second" with "password"
        And I press "register"
        Then I should see "Please enter a valid email address"

    @registration
    Scenario: I cannot register with a blank email address
        When I am on "/en/register"
        And I check "registration_form_agreeTerms"
        And I fill in "registration_form_email" with ""
        And I fill in "registration_form_password_first" with "password"
        And I fill in "registration_form_password_second" with "password"
        And I press "register"
        Then I should see "Please enter an email address"

    @registration
    Scenario: I cannot register with a blank password
        When I am on "/en/register"
        And I check "registration_form_agreeTerms"
        And I fill in "registration_form_email" with "user@example.com"
        And I fill in "registration_form_password_first" with ""
        And I fill in "registration_form_password_second" with ""
        And I press "register"
        Then I should see "Please enter a password"

    @registration
    Scenario: Password should be at least 8 characters
        When I am on "/en/register"
        And I check "registration_form_agreeTerms"
        And I fill in "registration_form_email" with "user@example.com"
        And I fill in "registration_form_password_first" with "123456"
        And I fill in "registration_form_password_second" with "123456"
        And I press "register"
        Then I should see "Your password should be at least 8 characters"

    @registration
    Scenario: Passwords must match
        When I am on "/en/register"
        And I check "registration_form_agreeTerms"
        And I fill in "registration_form_email" with "user@example.com"
        And I fill in "registration_form_password_first" with "123abc"
        And I fill in "registration_form_password_second" with "abc123"
        And I press "register"
        Then I should see "Passwords do not match"

    @registration
    Scenario: My mix of upper and lowercase email with whitespace is normalised to lowercase without whitespace
        Given I am on "/en/register"
        And I fill in "   uSeR@example.com   " for "registration_form_email"
        And I fill in "password" for "registration_form_password_first"
        And I fill in "password" for "registration_form_password_second"
        And I check "registration_form_agreeTerms"
        And I press "Register"
        And I should receive a confirmation email to "user@example.com"
        And I click the confirmation link and see "Your account is now enabled. You can now login"
        And I fill in "uSeR@example.com" for "email"
        And I fill in "password" for "password"
        And I press "Log in"
        Then I should see "Search"

    @registration
    Scenario: My email address is kept private if I already have an account on the site
        Given the following profiles exist:
            | email            | attributes   | requirements   | city   | age |
            | user@example.com | blue, square | yellow, circle | London | 30  |
        And I am on "/en/register"
        And I fill in "user@example.com" for "registration_form_email"
        And I fill in "password" for "registration_form_password_first"
        And I fill in "password" for "registration_form_password_second"
        And I check "registration_form_agreeTerms"
        And I press "Register"
        Then I should be on "/en/login"
        And I should see "Registration successful. Please check your email to confirm your account"
        And I should receive an already exists email to "user@example.com"
        And I can reset my password using the link