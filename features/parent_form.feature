Feature:

	As a parent
	So that I can select the right instruments for my child
	When I am on the parent form
	I should see all available instruments

Background: User visits home page first

	Given I am on the home page

Scenario: Basic Happy path testing

	Then I am on the parent form

	And I fill in the parent form with basic information
	
	Then I press "Submit"
	Then I should see "Your form has been submitted. We will be sending out the results through email soon."