Feature:
    As an administrator I can view moderators

    @moderator
    Scenario: I can view moderators
        Given a moderator exists with email "moderator@example.com"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/moderators"
        Then I should see "moderator@example.com"

    @moderator
    Scenario: I am notified when there are no moderators
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/moderators"
        Then I should see "No moderators"
