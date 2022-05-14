Feature:
    As a user I can choose to be notified when I receive a new match

    @message
    Scenario: I want to notified when I receive a new match
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        When the user "bristol_1@example.com" sends the message "Hello" to "bath_1@example.com"
        Then  "bath_1@example.com" should have a new message with "Hello" from "bristol_1@example.com"
        And the user "bath_1@example.com" should have a new match email

    @message
    Scenario: I don't want to notified when I receive a new match
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And the user "bath_1@example.com" has set "newMatchNotifications" to "false"
        When the user "bristol_1@example.com" sends the message "Hello" to "bath_1@example.com"
        Then  "bath_1@example.com" should have a new message with "Hello" from "bristol_1@example.com"
        And the user "bath_1@example.com" should not have a new match email

    @message
    Scenario: I am notified when there is an unread thread
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
            | london_1@example.com  | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bath_1@example.com" has a subscription
        And the user "london_1@example.com" has a subscription
        When the user "bath_1@example.com" sends the message "Hello" to "bristol_1@example.com"
        And I am logged in with "bristol_1@example.com"
        Then I should see "Matches (1)"
        When the user "bath_1@example.com" sends the message "Another" to "bristol_1@example.com"
        And I am on "/en/user/matches"
        Then I should see "Matches (1)"
        And I should see "Another"
        And the user "london_1@example.com" sends the message "Hi" to "bristol_1@example.com"
        And I am on "/en/user/matches"
        Then I should see "Matches (2)"
        And I should see "Hi"
        And I should see "Another"
        And I follow "bath_1"
        Then I should see "Matches (1)"
        And I am on "/en/user/matches"
        And I follow "london_1"
        Then I should not see "Matches (1)"

    @message
    Scenario: I am not notified for new messages from users I have blocked
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bath_1@example.com" has a subscription
        When the user "bath_1@example.com" sends the message "Hello" to "bristol_1@example.com"
        And I am logged in with "bristol_1@example.com"
        Then I should see "Matches (1)"
        And the following blocks exist
            | email                 | block              |
            | bristol_1@example.com | bath_1@example.com |
        And I am on "/"
        Then I should not see "Matches (1)"