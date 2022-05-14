Feature:
    As an administrator I can suspend a user

    @suspension
    Scenario: I can view administrator specific rules
        Given the following profiles exist:
            | email                 |
            | user@example.com      |
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/search/user"
        And I fill in "user@example.com" for "search_term_form_term"
        And I press "Search"
        And I follow "user@example.com"
        And I follow "Permanently suspend"
        Then I should see "Banned for subscription chargeback"