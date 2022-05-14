Feature: As an administrator, I can view statistics

    Scenario: An administrator I can view statistics
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/statistics"
        Then I should see "Open reports"