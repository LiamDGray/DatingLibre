Feature:
    I can moderate user profile images

    Scenario: As a moderator I can see a list of unmoderated images
        Given the following profiles exist:
            | email                    | attributes   | requirements   | city    | age |
            | bristol_blue@example.com | blue, square | yellow, circle | Bristol | 30  |
        And the user "bristol_blue@example.com" has uploaded a profile image
        And a moderator exists with email "moderator@example.com"
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/user/images"
        Then I can see an image uploaded by "bristol_blue@example.com"

    Scenario: As a moderator I can accept a profile image
        Given the following profiles exist:
            | email                    | attributes   | requirements   | city    | age |
            | bristol_blue@example.com | blue, square | yellow, circle | Bristol | 30  |
        And a moderator exists with email "moderator@example.com"
        And the user "bristol_blue@example.com" has uploaded a profile image
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/user/images"
        And I can see an image uploaded by "bristol_blue@example.com"
        And I press "Accept"
        Then I should see text matching "Accepted"
        And I should see text matching "No images to moderate"

    Scenario: As a moderator I can reject a profile image
        Given the following profiles exist:
            | email                    | attributes   | requirements   | city    | age |
            | bristol_blue@example.com | blue, square | yellow, circle | Bristol | 30  |
        And a moderator exists with email "moderator@example.com"
        And the user "bristol_blue@example.com" has uploaded a profile image
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/user/images"
        And I can see an image uploaded by "bristol_blue@example.com"
        And I press "Reject"
        Then I should see text matching "Rejected"
        And I should see text matching "No images to moderate"

    Scenario: As a moderator I can accept an image on the user's profile page
        Given the following profiles exist:
            | email                    | attributes   | requirements   | city    | age |
            | bristol_blue@example.com | blue, square | yellow, circle | Bristol | 30  |
        And a moderator exists with email "moderator@example.com"
        And the user "bristol_blue@example.com" has uploaded a profile image
        And I am logged in with "moderator@example.com"
        And I follow "moderator-profile-images"
        And I can see an image uploaded by "bristol_blue@example.com"
        And I follow "moderator-profile-image"
        And I press "Accept"
        Then I should see "Accepted"
        And I am on "/en/moderator/images/accepted"
        And I can see an image uploaded by "bristol_blue@example.com"

    Scenario: As a moderator I can see a list of recently accepted profile images
        Given the following profiles exist:
            | email                    | attributes     | requirements   | city    | age |
            | bristol_blue@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_yellow@example.com  | yellow, circle | blue, square   | Bath    | 30  |
        And a moderator exists with email "moderator@example.com"
        And the user "bristol_blue@example.com" has uploaded a profile image
        And the user "bath_yellow@example.com" has uploaded a profile image
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/user/images"
        And I can see an image uploaded by "bristol_blue@example.com"
        And I press "Accept"
        And I can see an image uploaded by "bath_yellow@example.com"
        And I press "Accept"
        And I follow "Recently accepted"
        And I can see an image uploaded by "bath_yellow@example.com"
        And I can see an image uploaded by "bristol_blue@example.com"

    Scenario: As a moderator I can see a list of recently rejected profile images
        Given the following profiles exist:
            | email                    | attributes     | requirements   | city    | age |
            | bristol_blue@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_yellow@example.com  | yellow, circle | blue, square   | Bath    | 30  |
        And a moderator exists with email "moderator@example.com"
        And the user "bristol_blue@example.com" has uploaded a profile image
        And the user "bath_yellow@example.com" has uploaded a profile image
        And I am logged in with "moderator@example.com"
        And I am on "/en/moderator/user/images"
        And I can see an image uploaded by "bristol_blue@example.com"
        And I press "Reject"
        And I can see an image uploaded by "bath_yellow@example.com"
        And I press "Reject"
        And I follow "Recently rejected"
        And I can see an image uploaded by "bristol_blue@example.com"
        And I can see an image uploaded by "bath_yellow@example.com"

    Scenario: As a moderator I cannot see another moderator's recently rejected profile images
        Given the following profiles exist:
            | email                    | attributes     | requirements   | city    | age |
            | bristol_blue@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_yellow@example.com  | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_blue@example.com" has uploaded a profile image
        And the user "bath_yellow@example.com" has uploaded a profile image
        And a moderator exists with email "moderator_1@example.com"
        And a moderator exists with email "moderator_2@example.com"
        And I am logged in with "moderator_1@example.com"
        And I am on "/en/moderator/user/images"
        And I can see an image uploaded by "bristol_blue@example.com"
        And I press "Reject"
        And I follow "Recently rejected"
        Then I can see an image uploaded by "bristol_blue@example.com"
        And I follow "Logout"
        And I am logged in with "moderator_2@example.com"
        And I am on "/en/moderator/user/images"
        And I can see an image uploaded by "bath_yellow@example.com"
        And I press "Reject"
        And I follow "Recently rejected"
        Then I can see an image uploaded by "bath_yellow@example.com"
        And I cannot see an image uploaded by "bristol_blue@example.com"

    Scenario: As a moderator I can see the latest unmoderated image at random
        Given the following profiles exist:
            | email                    | attributes     | requirements   | city    | age |
            | bristol_blue@example.com | blue, square   | yellow, circle | Bristol | 30  |
            | bath_yellow@example.com  | yellow, circle | blue, square   | Bath    | 30  |
        And the user "bristol_blue@example.com" has uploaded a profile image
        And the user "bath_yellow@example.com" has uploaded a profile image
        Then there should be one latest umoderated profile image at random