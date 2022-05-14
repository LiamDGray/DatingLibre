Feature:
    As moderator I can search for profiles by username

    @search
    Scenario: As a moderator I am able to search for profiles by username
        Given the following profiles exist:
            | email                    | attributes    | requirements | city   | age |
            | chelsea_blue@example.com | circle, green | square, blue | London | 30  |
        And a moderator exists with email "moderator@example.com"
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/search/profile"
        And I fill in "chelsea_Blue" for "search_term_form_term"
        And I press "search_term_form_submit"
        Then I should see "chelsea_blue"