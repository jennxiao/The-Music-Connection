Feature:

	As a parent
	So that I can select the right instruments for my child
	When I am on the parent form
	I should see all available instruments

Scenario:

	Given I am on the teacher form
	And I select "Piano" and "Violin"
	Then I should see "Your form has been submitted. We will be sending out the results through email soon."