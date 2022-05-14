Feature:
    Moderators can close reports

    @report
    Scenario: As a moderator I can close an open report.
        Given the following profiles exist:
            | email                          | attributes     | requirements   | city   | age |
            | chelsea_blue@example.com       | blue, square   | yellow, circle | London | 30  |
            | westminster_yellow@example.com | yellow, circle | blue, square   | London | 30  |
        And a moderator exists with email "moderator@example.com"
        And the user "chelsea_blue@example.com" has reported "westminster_yellow@example.com"
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/reports"
        And I follow "View"
        Then I should see "Spam"
        And I should see "Open"
        And I press "Close report"
        Then I should see "Closed report"