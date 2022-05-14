Feature:
    I can report another user

    @report
    Scenario: I can report another user
        Given the following profiles exist:
            | email                          | attributes     | requirements   | city   | age |
            | chelsea_blue@example.com       | blue, square   | yellow, circle | London | 30  |
            | westminster_yellow@example.com | yellow, circle | blue, square   | London | 30  |
        And I am logged in with "chelsea_blue@example.com"
        And I am on "/en/user/profile/search"
        Then I should see "westminster_yellow"
        And I follow "westminster_yellow"
        And I follow "Report"
        Then I should see "westminster_yellow"
        And I should see "30"
        And I should see "London"
        And I should see "Circle"
        And I check "Spam"
        And I fill in "report_form_message" with "Extra context"
        And I press "Report"
        Then I should see "Reported user"
        And a report should exist for "westminster_yellow@example.com" from "chelsea_blue@example.com"

    @report
    Scenario: I can report another user without a message
        Given the following profiles exist:
            | email                          | attributes     | requirements   | city   | age |
            | chelsea_blue@example.com       | blue, square   | yellow, circle | London | 30  |
            | westminster_yellow@example.com | yellow, circle | blue, square   | London | 30  |
        And I am logged in with "chelsea_blue@example.com"
        And I am on "/en/user/profile/search"
        Then I should see "westminster_yellow"
        And I follow "westminster_yellow"
        And I follow "Report"
        And I check "Spam"
        And I press "Report"
        Then I should see "Reported user"
        And a report should exist for "westminster_yellow@example.com" from "chelsea_blue@example.com"

    @report
    Scenario: I cannot report the same user twice
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
            | bath_2@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And I am logged in with "bristol_1@example.com"
        And I am on "/en/user/profile/search"
        Then I should see "bath_1"
        And I follow "bath_1"
        And I follow "Report"
        And I check "Spam"
        And I fill in "report_form_message" with "Extra context"
        And I press "Report"
        Then I should see "Reported user"
        And I follow "Report"
        Then I should see "You have reported this user"
        And I am on "/en/user/profile/search"
        Then I should see "bath_2"
        And I follow "bath_2"
        And I follow "Report"
        And I check "Spam"
        And I press "Report"
        Then I should see "Reported user"

    @report
    Scenario: A user should be able to report the user again after the report has been closed.
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
        And the user "chelsea_blue@example.com" has reported "westminster_yellow@example.com"