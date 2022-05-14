Feature:
    The site should be restricted according to user role

    @security
    Scenario: public cannot access profile
        Given I am on "/en/user/profile"
        Then I should be on "/en/login"

    @security
    Scenario: public cannot access profile without locale
        Given I am on "/user/profile"
        Then I should see "404"

    @security
    Scenario: public cannot access locations
        Given I am on "/user/location/region/4557207a-7936-4e62-b995-d03948fa66f7/cities"
        Then I should be on "/en/login"