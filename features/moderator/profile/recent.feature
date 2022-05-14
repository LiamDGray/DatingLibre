Feature:
    As moderator I can search for profiles by username

    @search
    Scenario: As a moderator I can view profiles of recently logged in users
        Given the following profiles exist:
            | email                    |
            | chelsea_blue@example.com |
        And a moderator exists with email "moderator@example.com"
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/profiles/recent"
        Then I should see "chelsea_blue"

    @search
    Scenario: As a moderator I can view when there are no recent users
        Given a moderator exists with email "moderator@example.com"
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/profiles/recent"
        Then I should see "No recently logged in users"