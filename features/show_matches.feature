Feature:
	As a TMC User
	So that I can tell who is matched with who
	And be able to read the information in rows
	I want the matching page to display information in each row

Background:
	Given the form is open
	Given I have logged into the admin

Scenario: Teacher submitted 1 form and tutor submitted 1 form

	And I submit a teacher form
	And I submit a tutor form
	And I am on the admin home page

	Then I follow "generate matches"
	Then I should see "INSERT SOMETHING TO SEE" in "PROBABLY SOME ID FIELD"

Scenario: Parent submitted 1 form and tutor submitted 1 form
