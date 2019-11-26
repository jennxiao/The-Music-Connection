Feature:

	As a teacher
	So that I can select the right instruments for my class
	When I am on the teacher form
	I should see all available instruments

Background: User visits home page first

	Given I am on the home page

Scenario: Basic Happy path testing

	Then I am on the teacher form

	And I fill in the teacher form with basic information

	And I check "Piano"
	Then I press "Submit"
	Then I should see "Your form has been submitted. We will be sending out the results through email soon."

Scenario: Basic Sad path testing

	Given I am on the teacher form

Scenario: Adding 1 Other instrument Happy Path Testing

	Given I am on the teacher form

	And I fill in the teacher form with basic information

	And I fill in "Other" with "Harpsichord"
	Then I press "Submit"
	Then I should see "Your form has been submitted. We will be sending out the results through email soon."

Scenario: Adding 1+ other instruments Happy Path Testing

	Given I am on the teacher form

	And I fill in the teacher form with basic information

	And I fill in "Other" with "Harpsichord"
	Then I press "add_instrument"
	And I fill in "Other" with "Bongos"
	Then I press "Submit"
	Then I should see "Your form has been submitted. We will be sending out the results through email soon."

Scenario: Removing an "Other" Instrument

	Given I am on the teacher form

	And I fill in the teacher form with basic information

	And I fill in "Other" with "Harpsichord"
	Then I press "add_instrument"
	And I fill in "Other" with "Bongos"
	Then I press "rem_instrument"
	Then I press "Submit"
	Then I should see "Your form has been submitted. We will be sending out the results through email soon."
