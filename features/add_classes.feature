Feature:
	As a teacher
	So that I don't have to submit multiple forms
	When I am on the teacher form
	I should be able to add multiple classes:

Background: Form is open and User visits home page first
	Given form is open
	Given I am on the home page
	Then I am on the teacher form

Scenario: Teacher adds 1 class and submits
	Then I fill in class "0" with basic information
	And I check class "0" "Piano"
	Then I press "Add Another Class"
	And I fill in class "1" with basic information
	And I check class "1" "Piano"
	Then I press "Submit"
	Then I should see "Your form has been submitted. We will be sending out the results through email soon."

