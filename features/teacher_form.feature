Feature: Teacher submits application
	As a teacher
	So that a tutor from TMC can help teach my class
	When I visit the TMC website
	I should be able to submit an application for my class

  Background: Teacher visits home page first
    Given form is open
    And I am on the home page
    Then I am on the teacher form

  Scenario: Teacher submits application with valid parameters (happy path)
    And I fill in the teacher form with basic information
    Then I fill in class "0" with basic information
    And I check class "0" "Piano"
    Then I press "Submit"
    Then I should see "Your form has been submitted. We will be sending out the results through email soon."

  Scenario: Teacher adds instrument not listed (happy path)
    And I fill in the teacher form with basic information
    Then I fill in class "0" with basic information
    And I check class "0" "Piano"
    And I fill in class "0" "Other" with "Harpsichord"
    Then I press "Submit"
    Then I should see "Your form has been submitted. We will be sending out the results through email soon."

  Scenario: Teacher adds multiple instruments not listed (happy path)
    And I fill in the teacher form with basic information
    Then I fill in class "0" with basic information
    And I fill in class "0" "Other" with "Harpsichord"
    Then I press "add_instrument"
    And I fill in class "0" "Other" with "Bongos"
    Then I press "Submit"
    Then I should see "Your form has been submitted. We will be sending out the results through email soon."

  Scenario: Teacher removes added but extraneous instrument (happy path)
    And I fill in the teacher form with basic information
    Then I fill in class "0" with basic information
    And I fill in class "0" "Other" with "Harpsichord"
    Then I press "add_instrument"
    And I fill in class "0" "Other" with "Bongos"
    Then I press "rem_instrument"
    Then I press "Submit"
    Then I should see "Your form has been submitted. We will be sending out the results through email soon."
