Feature:
    Presigned image URLs can be refreshed

    @image
    Scenario:
        Given the following profiles exist:
            | email            |
            | user@example.com |
        When I upload "cat.jpg" as the profile image for "user@example.com"
        And the profile image for "user@example.com" has expired
        When the secure image refresh task has run
        Then generate a new expiry date for the profile image of "user@example.com"