Feature:
    User archives are not retained indefinitely

    @account
    Scenario: Old user archives are purged
        Given the following profiles exist:
            | email            | attributes   | requirements   | city   | age |
            | user@example.com | blue, square | yellow, circle | London | 30  |
        And I create an old archive for "user@example.com"
        And I run the purge user archives command
        Then there should not be an archive for "user@example.com"