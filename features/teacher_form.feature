Feature:

	As a parent
	So that I can select the right instruments for my child
	When I am on the parent form
	I should see all available instruments

Background: User visits home page first
	Given I am on the home page

Scenario: Happy path testing

	Then I am on the teacher form

	When I fill in "Teacher Name" with "Anthony Zhou"	
	When I fill in "Phone Number" with "847-873-2739"
	When I fill in "Email Address" with "anthonyfzhou@berkeley.edu"

	Then I press "Next"

	When I fill in "Class Name" with "Example Class"
	And I fill in "School" with "Berkeley Elementary"

	And I select "Monday" from "Class Time"
	And I check "Piano"
	Then I press "Submit"
	Then I should see "Your form has been submitted. We will be sending out the results through email soon."

Scenario: Sad path testing

	Given I am on the teacher form
