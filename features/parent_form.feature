Feature: Parent submits application
	As a parent
	So that I can enroll my child into the TMC program
	When I visit the TMC website
	I should be able to submit an application for my child

  Background: Parent visits home page first
    Given form is open
    And I am on the home page
    Then I am on the parent form

  Scenario: Parent submits application with valid parameters (happy path)
    And I fill in the parent form with basic information
    Then I press "Submit"
    Then I should see "Your form has been submitted. We will be sending out the results through email soon."
