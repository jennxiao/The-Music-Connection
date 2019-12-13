Feature: 

	As a TMC admin
	So that I can receive feedback from tutor applicants
	I want to be able to add a link in the tutor form
	And edit the link and text

Background:

	Given form is open

@javascript
Scenario: Update link and ensure it's changed

	And I log in as admin
	Then I follow "Edit Form Settings"

	And I fill in "tutor_link" with "www.reddit.com/r/leagueoflegends"
	And I press "Update Link"
	Then I should see "Tutor link has been updated!"

	Then I am on the tutor form 

	And I fill in "Name" with "Tutor Anthony Zhou"
	And I fill in "Phone Number" with "111-111-1111"
	And I fill in "Email address" with "Tutor@berkeley.edu"
	And I fill in "SID" with "3032748539"
	And I fill in "Major" with "Computer Science"
	And I select "Tuesday" from "Time Availability" in tutor form
	And I check "K"
	And I press "Next"
	  
	And I check "Violin"
	And I press "Next"
	  
	And I choose "InClass_Yes"
	And I press "Next"
	  
	And I choose "Private_Yes"
	And I press "Next"
	  
	And I check "Member Commitment Policy"
	And I check "Attendance Policy"
	And I press "Next"
	  
	And I choose "radio-new"
	And I press "Next"

	Then I should see "www.reddit.com/r/leagueoflegends"

@javascript
Scenario: Update link and ensure it's changed

	And I log in as admin
	Then I follow "Edit Form Settings"

	And I fill in "tutor_text" with "ooga booga"
	And I press "Update Tutor Text"
	Then I should see "Tutor text has been updated!"

	Then I am on the tutor form 

	And I fill in "Name" with "Tutor Anthony Zhou"
	And I fill in "Phone Number" with "111-111-1111"
	And I fill in "Email address" with "Tutor@berkeley.edu"
	And I fill in "SID" with "3032748539"
	And I fill in "Major" with "Computer Science"
	And I select "Tuesday" from "Time Availability" in tutor form
	And I check "K"
	And I press "Next"
	  
	And I check "Violin"
	And I press "Next"
	  
	And I choose "InClass_Yes"
	And I press "Next"
	  
	And I choose "Private_Yes"
	And I press "Next"
	  
	And I check "Member Commitment Policy"
	And I check "Attendance Policy"
	And I press "Next"
	  
	And I choose "radio-new"
	And I press "Next"

	Then I should see "ooga booga"