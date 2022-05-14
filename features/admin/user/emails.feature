Feature: As an administrator, I can view emails sent to the user

    Scenario: An administrator I can view emails sent to the user
        When I am on "/en/register"
        And I follow "Register"
        And I check "registration_form_agreeTerms"
        And I fill in "registration_form_email" with "user@example.com"
        And I fill in "registration_form_password_first" with "password"
        And I fill in "registration_form_password_second" with "password"
        And I press "Register"
        Then I should be on "/en/login"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/search/user"
        And I fill in "search_term_form_term" with "user@example.com"
        And I press "Search"
        And I follow "user@example.com"
        And I follow "Emails"
        Then I should see "Signup"

    @search
    Scenario: As an administrator, I can see where a user has no emails
        Given the following profiles exist:
            | email                    | attributes    | requirements | city   | age |
            | chelsea_blue@example.com | circle, green | square, blue | London | 30  |
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/search/user"
        And I fill in "Chelsea_blue" for "search_term_form_term"
        And I press "Search"
        And I follow "chelsea_blue@example.com"
        And I follow "Emails"
        Then I should see "No emails"