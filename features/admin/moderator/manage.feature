Feature:
    As an administrator I can manage moderators

    @moderator
    Scenario: I can edit moderators
        Given a moderator exists with email "moderator@example.com"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/moderators"
        Then I should see "moderator@example.com"
        And I should see "Enabled"
        And I follow "Edit"
        Then I should see "Email"
        And I fill in "foobar@example.com" for "moderator_form_email"
        And I uncheck "moderator_form_enabled"
        And I press "Submit"
        And I should see "Successfully updated moderator"
        And I should see "foobar@example.com"
        And I should see "Not enabled"

    @moderator
    Scenario: I can edit a moderator to an email address that already exists
        Given a moderator exists with email "moderator@example.com"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/moderators"
        And I follow "Edit"
        And a moderator exists with email "moderator2@example.com"
        And I fill in "moderator2@example.com" for "moderator_form_email"
        And I press "Submit"
        And I should see "Email already exists"

    @moderator
    Scenario: I can add a moderator
        Given an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/moderator"
        And I fill in "moderator@example.com" for "moderator_email_form_email"
        And I press "Submit"
        Then I should see "Successfully added moderator"

    @moderator
    Scenario: I cannot add a moderator with an email that already exists
        Given a moderator exists with email "moderator@example.com"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/moderator"
        And I fill in "moderator@example.com" for "moderator_email_form_email"
        And I press "Submit"
        Then I should see "A moderator with this email address already exists"

    @moderator
    Scenario: I can delete a moderator
        Given a moderator exists with email "moderator@example.com"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/moderators"
        Then I should see "moderator@example.com"
        And I follow "Delete"
        And I fill in "moderator@example.com" for "confirm_email_form_email_first"
        And I press "Confirm"
        Then I should see "Successfully deleted moderator"
        And I should not see "moderator@example.com"

    @moderator
    Scenario: I cannot delete a moderator without confirming the moderator's email address
        Given a moderator exists with email "moderator@example.com"
        And an administrator exists with email "admin@example.com"
        And I am logged in with "admin@example.com"
        And I am on "/en/admin/moderators"
        Then I should see "moderator@example.com"
        And I follow "Delete"
        And I fill in "moderator2@example.com" for "confirm_email_form_email_first"
        And I press "Confirm"
        Then I should see "This value is not valid"