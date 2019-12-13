Feature:

	As a TMC Admin
	So that I can view the generated matches
	The matches should be displayed in a table with each column being a matched element

Background:

	Given form is open
	And I am on the home page
	And I fill in the tutor form with basic information
	And I am on the home page

Scenario: display match with teacher (happy path)

	Then I am on the teacher form
	And I fill out the teacher form
	Then I log in as admin
	And I follow "Generate Matches"

	Then I should see "Tutor Anthony Zhou"
	Then I should see "111-111-1111"