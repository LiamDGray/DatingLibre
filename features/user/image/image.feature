Feature:
    I can upload images up to S3

    @image
    Scenario: I can save a profile image
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When I upload "cat.jpg" as the profile image for "user@example.com"
        Then the image should be set as the profile image for "user@example.com"

    @image
    Scenario: I can only save one profile image
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When I upload "cat.jpg" as the profile image for "user@example.com"
        And I upload "cat.jpg" as the profile image for "user@example.com"
        # there is a database constraint that enforces one profile image per user
        Then the image should be set as the profile image for "user@example.com"

    @image
    Scenario: I can save a general image
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When I upload "cat.jpg" as an image for "user@example.com"
        Then an image should exist for "user@example.com"

    @image
    Scenario: I can delete an image
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When I upload "cat.jpg" as the profile image for "user@example.com"
        And I delete the profile image for "user@example.com"
        Then there should be no images for "user@example.com"
