Feature: I can download my account's data

    @account
    Scenario: I can download my account's data
        Given the following profiles exist:
            | email                   | attributes     | requirements   | city    | age |
            | first_user@example.com  | blue, square   | yellow, circle | Bristol | 30  |
            | second_user@example.com | yellow, circle | blue, square   | Bath    | 30  |
        And the user "first_user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And the user "first_user@example.com" sends the message "Let us go then, you and I" to "second_user@example.com"
        And I am logged in with "first_user@example.com"
        When I go to "/en/user/data"
        Then I should see "Confirm your password below to download your user data"
        And I fill in "user_data_form_password" with "password"
        And I press "Download"
        Then the response should contain "userAttributes"
        And the response should contain "England"
        And the response should contain "blue"
        And the response should contain "square"
        And the response should contain "yellow"
        And the response should contain "circle"
        And the response should contain "Let us go then, you and I"
        And the response should contain "manual"
        And the response should contain "985938"
        And the response should contain "second_user"
        And the response should contain "first_user"
        # email addresses of message participants
        # should not be part of the archive
        And the response should not contain "second_user@example.com"

    @account
    Scenario: I cannot download my account's data with an incorrect password
        Given the following profiles exist:
            | email                   | attributes     | requirements   | city    | age |
            | first_user@example.com  | blue, square   | yellow, circle | Bristol | 30  |
        And I am logged in with "first_user@example.com"
        When I go to "/en/user/data"
        Then I should see "Confirm your password below to download your user data"
        And I fill in "user_data_form_password" with "pass"
        And I press "Download"
        Then I should see "Incorrect password"

    # A block implies that the message recipient no longer
    # consents for their messages to be shared.
    #
    # Messages should also not be shared, as this would
    # mean the user who issued the block no longer has
    # plausible deniability (blocking a user, and deleting
    # one's own account looks the same).
    @account
    Scenario: I do not see messages from users that have blocked me in my account data
        Given the following profiles exist:
            | email                   | attributes     | requirements   | city    | age |
            | first_user@example.com  | blue, square   | yellow, circle | Bristol | 30  |
            | second_user@example.com | yellow, circle | blue, square   | Bath    | 30  |
        And the user "first_user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And the user "first_user@example.com" sends the message "Let us go then, you and I" to "second_user@example.com"
        And the following blocks exist
            | email                    | block                          |
            | second_user@example.com  | first_user@example.com |
        And I am logged in with "first_user@example.com"
        When I go to "/en/user/data"
        Then I should see "Confirm your password below to download your user data"
        And I fill in "user_data_form_password" with "password"
        And I press "Download"
        Then the response should not contain "Let us go then, you and I"
        Then the response should not contain "second_user"

    @account
    Scenario: I do not see messages from users that I have blocked in my account data
        Given the following profiles exist:
            | email                   | attributes     | requirements   | city    | age |
            | first_user@example.com  | blue, square   | yellow, circle | Bristol | 30  |
            | second_user@example.com | yellow, circle | blue, square   | Bath    | 30  |
        And the user "first_user@example.com" has bought a new subscription from "manual" that has ID "985938"
        And the user "first_user@example.com" sends the message "Let us go then, you and I" to "second_user@example.com"
        And the following blocks exist
            | email                    | block                          |
            | first_user@example.com   | second_user@example.com |
        And I am logged in with "first_user@example.com"
        When I go to "/en/user/data"
        Then I should see "Confirm your password below to download your user data"
        And I fill in "user_data_form_password" with "password"
        And I press "Download"
        Then the response should not contain "Let us go then, you and I"
        Then the response should not contain "second_user"