Feature:
    As a user
    I want to be able to upload a new profile image

    @image
    @javascript
    Scenario: I want to add a profile image to my profile
        Given the following profiles exist:
            | email            | city   | age |
            | user@example.com | London | 30  |
        Given I am logged in with "user@example.com"
        When I am on the profile image page
        And I attach the file "cat.jpg" to "inputImageButton"
        And I press "Submit"
        And I wait until the profile image has uploaded
        And I open the my own profile index page
        Then I should see "Your profile image is awaiting moderation"
        And I should not see "profile.jpg"

    @image
    @javascript
    Scenario: I want to add a profile image without first filling in my profile
        Given a user with email "noprofile@example.com"
        And I log in using email "noprofile@example.com"
        When I am on the profile image page
        And I attach the file "cat.jpg" to "inputImageButton"
        And I press "Submit"
        And I wait until the profile image has uploaded
        And I am on "/en/user/profile/edit"
        Then I should see "Your profile image is awaiting moderation"
        And the response should contain "profile.jpg"

    @image
    Scenario: I can update my existing profile image with a new one
        Given a user with email "existingimage@example.com"
        And the user "existingimage@example.com" has uploaded a profile image
        When the user "existingimage@example.com" has uploaded a profile image

    @image
    Scenario: I can't see another user's un-moderated profile image on their profile
        Given the following profiles exist:
            | email                    | attributes   | requirements   | city    | age |
            | bristol_blue@example.com | blue, square | yellow, circle | Bristol | 30  |
        When the user "bristol_blue@example.com" has uploaded a profile image
        Then another user should not be able to see the profile image of "bristol_blue@example.com"

    @image
    Scenario: I can see another user's profile image when it has been accepted
        Given the following profiles exist:
            | email                    | attributes   | requirements   | city    | age |
            | bristol_blue@example.com | blue, square | yellow, circle | Bristol | 30  |
        And the user "bristol_blue@example.com" has uploaded a profile image
        And the profile image for "bristol_blue@example.com" has passed moderation
        Then another user should be able to see the profile image of "bristol_blue@example.com"

    @image
    Scenario: I should see my profile image failed moderation
        Given the following profiles exist:
            | email            | city   | age |
            | user@example.com | London | 30  |
        And the user "user@example.com" has uploaded a profile image
        And the profile image for "user@example.com" has failed moderation
        And I am logged in with "user@example.com"
        And I open the my own profile index page
        Then I should see "Your profile image has failed moderation"

