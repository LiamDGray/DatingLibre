Feature:
    As an administrator I can view recently logged in users

    @search
    Scenario: As administrator I can view profiles of recently logged in users
        Given the following profiles exist:
            | email                    |
            | chelsea_blue@example.com |
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/users/recent"
        Then I should see "chelsea_blue"

    @search
    Scenario: As administrator I can see no recently logged in users
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/users/recent"
        Then I should see "No recently logged in users"