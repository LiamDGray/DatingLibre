Feature:
    As an administrator I can view user archives

    @archives
    Scenario: I can view archives of deleted users
        Given the following profiles exist:
            | email                 |
            | user@example.com      |
            | recipient@example.com |
        And an administrator exists with email "admin@example.com"
        And the user "recipient@example.com" has reported "user@example.com"
        And the moderator "admin@example.com" has suspended "user@example.com" for "spam" for "72" hours
        And I am logged in with "user@example.com"
        And I follow "Account"
        And I follow "Delete"
        And I fill in "password" for "delete_account_form_password"
        And I press "Permanently delete my account"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/user/archives"
        Then I should see "user@example.com"
        And I follow "Download"
        Then the response should contain "user@example.com"
        Then the response should contain "spam"
        Then the response should contain "72"
        Then the response should contain "Just a flesh wound"

   @archives
   Scenario: I can view empty list of deleted users
       Given an administrator exists with email "admin@example.com"
       And I am logged in with "admin@example.com"
       And I am on "/en/admin/user/archives"
       Then I should see "No user archives"

   @archives
   Scenario: An administrator can search for an archive by email
       Given the following profiles exist:
           | email                 |
           | uSeR@example.com      |
       And an administrator exists with email "admin@example.com"
       And I am logged in with "user@example.com"
       And I follow "Account"
       And I follow "Delete"
       And I fill in "password" for "delete_account_form_password"
       And I press "Permanently delete my account"
       And I am logged in with "admin@example.com"
       And I am on "/en/admin/user/archive/search"
       And I fill in "usEr@example.com" for "search_term_form_term"
       And I press "Search"
       Then I should see "Download"

