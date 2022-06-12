Feature:
    As an administrator I can generate a user archive

    @archives
    Scenario: An administrator I generate an archive for a user
        Given the following profiles exist:
            | email                    |
            | user@example.com |
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/search/user"
        And I fill in "search_term_form_term" with "user@example.com"
        And I press "Search"
        And I follow "user@example.com"
        And I follow "Archive"
        And I press "Generate"
        Then I should be on "/en/admin/user/archives"
        And I should see "user@example.com"