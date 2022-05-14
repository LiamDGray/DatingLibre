Feature:
    As a user I want to block/unmatch another user

    @block
    Scenario: I want to block another user
        Given the following profiles exist:
            | email                          | attributes     | requirements   | city   | age |
            | chelsea_blue@example.com       | blue, square   | yellow, circle | London | 30  |
            | westminster_yellow@example.com | yellow, circle | blue, square   | London | 30  |
        And the following filters exist:
            | email                    | distance | min_age | max_age |
            | chelsea_blue@example.com | 100000   | 18      | 100     |
        And the following blocks exist
            | email                    | block                          |
            | chelsea_blue@example.com | westminster_yellow@example.com |
        When the user "chelsea_blue@example.com" searches for matches
        Then the user "westminster_yellow@example.com" does not match

    @block
    Scenario: I have been blocked by another user
        Given the following profiles exist:
            | email                          | attributes     | requirements   | city   | age |
            | chelsea_blue@example.com       | blue, square   | yellow, circle | London | 30  |
            | westminster_yellow@example.com | yellow, circle | blue, square   | London | 30  |
        And the following filters exist:
            | email                          | distance | min_age | max_age |
            | westminster_yellow@example.com | 100000   | 18      | 100     |
        And the following blocks exist
            | email                    | block                          |
            | chelsea_blue@example.com | westminster_yellow@example.com |
        When the user "westminster_yellow@example.com" searches for matches
        Then the user "chelsea_blue@example.com" does not match

    @block
    Scenario: If I have been blocked, I should lose access to their profile
        Given the following profiles exist:
            | email                          | attributes     | requirements   | city   | age |
            | chelsea_blue@example.com       | blue, square   | yellow, circle | London | 30  |
            | westminster_yellow@example.com | yellow, circle | blue, square   | London | 30  |
        And the following blocks exist
            | email                    | block                          |
            | chelsea_blue@example.com | westminster_yellow@example.com |
        And I am logged in with "westminster_yellow@example.com"
        Then the profile of "chelsea_blue@example.com" should be 404
        Then the message page of "chelsea_blue@example.com" should be 404
        Then the block page of "chelsea_blue@example.com" should be 404

    @block
    Scenario: I can block another user
        Given the following profiles exist:
            | email                          | attributes     | requirements   | city   | age |
            | chelsea_blue@example.com       | blue, square   | yellow, circle | London | 30  |
            | westminster_yellow@example.com | yellow, circle | blue, square   | London | 30  |
        And I am logged in with "chelsea_blue@example.com"
        And I am on "/en/user/profile/search"
        Then I should see "westminster_yellow"
        And I follow "westminster_yellow"
        And I follow "Block"
        And I press "Confirm"
        Then I should be on "/en/user/profile/search"
        And I should see "Blocked user"
        And I should not see "westminster_yellow"

    @block
    Scenario: I should not see an unmoderated profile image on the user's block page
        Given the following profiles exist:
            | email                          | attributes     | requirements   | city   | age |
            | chelsea_blue@example.com       | blue, square   | yellow, circle | London | 30  |
            | westminster_yellow@example.com | yellow, circle | blue, square   | London | 30  |
        And the user "westminster_yellow@example.com" has uploaded a profile image
        And I am logged in with "chelsea_blue@example.com"
        And I am on "/en/user/profile/search"
        Then I should see "westminster_yellow"
        And I follow "westminster_yellow"
        And I follow "Block"
        Then I should see the anonymous profile image
