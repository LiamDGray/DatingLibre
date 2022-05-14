Feature: As an administrator, I can view the site's configuration

    Scenario: An administrator I can see the Manual subscription provider
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/configuration"
        Then I should see "Manual"