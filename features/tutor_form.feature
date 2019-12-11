Feature: Tutor submits application
	As a tutor
	So that I can teach students in the TMC program
	When I visit the TMC website
	I should be able to submit an application for myself

Background: Tutor visits home page first
  Given form is open
  And I am on the home page
  Then I am on the tutor form

@javascript
Scenario: Tutor submits application with valid parameters (happy path)
  And I fill in the tutor form with basic information
  Then I press "Submit"
  Then I should see "Your form has been submitted. We will be sending out the results through email soon."
