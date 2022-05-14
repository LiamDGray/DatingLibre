Feature:
    As an administrator I can search for users

    @search
    Scenario: As an administrator I am able to search for users by email
        Given the following profiles exist:
            | email                    | attributes    | requirements | city   | age |
            | chelsea_blue@example.com | circle, green | square, blue | London | 30  |
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/search/user"
        And I fill in "Chelsea_blue@example.com" for "search_term_form_term"
        And I press "Search"
        Then I should see "chelsea_blue@example.com"

    @search
    Scenario: As an administrator I am able to search for users by username
        Given the following profiles exist:
            | email                    | attributes    | requirements | city   | age |
            | chelsea_blue@example.com | circle, green | square, blue | London | 30  |
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/search/user"
        And I fill in "Chelsea_blue" for "search_term_form_term"
        And I press "Search"
        Then I should see "chelsea_blue@example.com"

    @search
    Scenario: As an administrator I am informed when there are no results
        Given an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/search/user"
        And I fill in "abcd" for "search_term_form_term"
        And I press "Search"
        Then I should see "No results, please try changing your search criteria"