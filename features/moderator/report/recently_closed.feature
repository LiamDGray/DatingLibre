Feature:
    Moderators can view recently closed reports

    @report
    Scenario: As a moderator I can view recently closed reports
        Given the following profiles exist:
            | email                          |
            | chelsea_blue@example.com       |
            | westminster_yellow@example.com |
        And a moderator exists with email "moderator@example.com"
        And the user "chelsea_blue@example.com" has reported "westminster_yellow@example.com"
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/reports/closed"
        Then I should see "No reports to moderate"
        And I am on "/en/moderator/reports"
        And I follow "Reports"
        Then I should see "Spam"
        Then I should see "chelsea_blue"
        And I follow "View"
        And I press "Close"
        And I am on "/en/moderator/reports/closed"
        Then I should see "chelsea_blue"


