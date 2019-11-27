Feature: Parent submits application
	As a parent
	So that I can enroll my child into the TMC program
	When I visit the TMC website
	I should be able to submit an application for my child.

Background: Parent visits home page first

	Given I am on the home page
  Given form is open

Scenario: Parent submits application with valid parameters

	Then I am on the parent form
	And I fill in the parent form with basic information
	Then I press "Submit"
	Then I should see "Your form has been submitted. We will be sending out the results through email soon."