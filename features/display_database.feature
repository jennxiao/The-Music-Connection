Feature:

	As a TMC Admin
	So that I can view everyone that has applied
	The database should be displayed in a table format

Background:

	Given form is open
	And I am on the home page

Scenario: display tutor, parent, and teacher

	And I fill in the tutor form with basic information
	And I am on the home page

	And I am on the teacher form
	Then I fill out the teacher form
	And I am on the home page

	Then I am on the parent form
	Then I fill in the parent form with basic information

	Then I log in as admin
	And I follow "Display Database"

	Then I should see "Anthony Zhou Parent"
	Then I should see "222-222-2222"
	Then I should see "Tutor Anthony Zhou"