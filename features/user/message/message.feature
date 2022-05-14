Feature:
    As a user
    I want to be able to message another user

    @message
    Scenario: I can send a message to another user
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        When the user "bristol_1@example.com" sends the message "Hello" to "bath_1@example.com"
        Then  "bath_1@example.com" should have a new message with "Hello" from "bristol_1@example.com"

    @message
    Scenario: I cannot send a blank message to another user
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And I am logged in with "bristol_1@example.com"
        And I am on "/en/user/profile/search"
        And I follow "bath_1"
        And I follow "Message"
        And I press "message_form_submit"
        Then I should see "Please enter a message"

    @message
    Scenario: I cannot send a message that is too long to another user
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And I am logged in with "bristol_1@example.com"
        And I am on "/en/user/profile/search"
        And I follow "bath_1"
        And I follow "Message"
        And I enter a message that is too long
        And I press "Send"
        Then I should see "This value is too long. It should have 1000 characters or less"

    @message @ui
    Scenario: I cannot send another user a message without a subscription
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And I am logged in with "bristol_1@example.com"
        And I navigate to message user "bath_1@example.com"
        Then I should see "A subscription is required to send the first message to this user"

    @message @ui
    Scenario: I can send a message if I have cancelled my subscription but it has not expired
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And the user "bristol_1@example.com" has cancelled their subscription
        And I am logged in with "bristol_1@example.com"
        And I navigate to message user "bath_1@example.com"
        And I should not see "Buy a subscription"

    @message @ui
    Scenario: I can send a message if I have cancelled my subscription but it has not expired
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription with expiry "2200-01-01" and status "CANCELLED"
        And I am logged in with "bristol_1@example.com"
        And I navigate to message user "bath_1@example.com"
        And I should not see "Buy"
        And I should see "Send"

    @message
    Scenario: I lose access to messages when that user blocks me
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the following blocks exist
            | email                 | block              |
            | bristol_1@example.com | bath_1@example.com |
        And the user "bath_1@example.com" has a subscription
        When the user "bath_1@example.com" sends the message "Hello" to "bristol_1@example.com"
        Then  "bristol_1@example.com" should have no messages

    @message
    Scenario: I can see my matches
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        When the user "bristol_1@example.com" sends the message "Hello" to "bath_1@example.com"
        And I am logged in with "bristol_1@example.com"
        And I navigate to the matches page
        Then I should see "Hello"

    @message
    Scenario: I can see the moderated profile image of my match
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And the user "bristol_1@example.com" sends the message "Hello" to "bath_1@example.com"
        And the user "bath_1@example.com" has uploaded a profile image
        And the profile image for "bath_1@example.com" has passed moderation
        And I am logged in with "bristol_1@example.com"
        And I navigate to the matches page
        Then I should see "Hello"
        And I should see "bath_1"
        And the profile image is displayed

    @message
    Scenario: I cannot see the unmoderated profile image of my match
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And the user "bristol_1@example.com" sends the message "Hello" to "bath_1@example.com"
        And the user "bath_1@example.com" has uploaded a profile image
        And I am logged in with "bristol_1@example.com"
        And I navigate to the matches page
        Then I should see "Hello"
        And I should see "bath_1"
        And the anonymous profile image should be displayed

    @message
    Scenario: The recipient can see their matches
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        When the user "bristol_1@example.com" sends the message "Hello" to "bath_1@example.com"
        And I am logged in with "bath_1@example.com"
        And I navigate to the matches page
        Then I should see "Hello"


    @message @ui
    Scenario: I can send another user a message
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And I am logged in with "bristol_1@example.com"
        And I navigate to message user "bath_1@example.com"
        And I send the message "Hello this is a new message"
        Then I should see "Sent message"
        And I should see "Hello this is a new message"
        And I should see "bristol_1"

    @message
    Scenario: I can see my most recent messages
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And I am logged in with "bristol_1@example.com"
        And I navigate to message user "bath_1@example.com"
        And I send the message "Hello this is a new message"
        And I send the message "Another message"
        And I am on "/en/user/matches"
        Then I should see "Another message"
        And I should see "bath_1"

    @message @ui
    Scenario: I can send messages to multiple users
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
            | london_1@example.com  | yellow, circle | blue, square   | London  | 30  |
        And the user "bristol_1@example.com" has a subscription
        And the user "bath_1@example.com" has a subscription
        And the user "london_1@example.com" has a subscription
        And I am logged in with "bristol_1@example.com"
        And I navigate to message user "bath_1@example.com"
        And I send the message "a truth universally acknowledged"
        And I navigate to message user "london_1@example.com"
        And I send the message "that is the question"
        And I am on "/en/user/matches"
        Then I should see "a truth universally acknowledged"
        And I should see "that is the question"
        And I follow "Logout"
        And I am logged in with "london_1@example.com"
        And I am on "/en/user/matches"
        Then I should see "bristol_1"
        And I should see "that is the question"
        And I should not see "a truth universally acknowledged"
        And I follow "bristol_1"
        Then I should see "that is the question"
        And I should not see "a truth universally acknowledged"

    @message
    Scenario: I only see the reply icon for the first message
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And I am logged in with "bristol_1@example.com"
        And I navigate to message user "bath_1@example.com"
        And I send the message "Hello this is a new message"
        And I am on "/en/user/matches"
        Then the response should not contain "reply-icon"
        And the response should contain "bath_1"
        And I navigate to message user "bath_1@example.com"
        And I send the message "This is a reply to the original message"
        And I am on "/en/user/matches"
        Then the response should contain "gherkin-replied"

    @message
    Scenario: I see highlighted new messages
        Given the following profiles exist:
            | email                 | attributes     | requirements   | city    | age |
            | bristol_1@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_1@example.com    | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_1@example.com" has a subscription
        And I am logged in with "bristol_1@example.com"
        And I navigate to message user "bath_1@example.com"
        And I send the message "Hello this is a new message"
        And I follow "Logout"
        And I am logged in with "bath_1@example.com"
        And I am on "/en/user/matches"
        Then I should see "bristol_1"
        And the response should contain "unread"
        And I follow "bristol_1"
        And I am on "/en/user/matches"
        Then the response should not contain "gherkin-unread"