Feature:
    I can change the language

    @account
    Scenario: I can override the default language
        Given the following profiles exist:
            | email            | attributes   | requirements   | city   | age |
            | user@example.com | blue, square | yellow, circle | London | 30  |
        And I am logged in with "user@example.com"
        And I go to "/en/user/locale"
        And I select "Deutsch" from "user_locale_form_locale"
        And I press "Update"
        Then I should see "Aktualisieren"
        And I should be on "/de/user/locale"
        And the locale for "user@example.com" should be "de"
        And I follow "Abmelden"
        Then I should be on "/de/login?logout=success"
        And I am logged in with "user@example.com"
        Then I should see "Abmelden"

