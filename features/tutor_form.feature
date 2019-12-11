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
  And I fill in "Name" with "Anthony Zhou"
  And I fill in "Phone Number" with "847-873-2739"
  And I fill in "Email address" with "anthonyfzhou@berkeley.edu"    
  And I fill in "SID" with "3032748539"
  And I fill in "Major" with "Computer Science"
  And I select "Tuesday" from "Time Availability" in tutor form
  And I check "K"
  And I press "next_btn"

  And I check "Violin"
  And I press "Next"

  And I choose "InClass_Yes"
  And I press "Next"

  And I choose "Private_Yes"
  And I press "Next"

  And I check "Member Commitment Policy"
  And I check "Attendance Policy"
  And I press "Next"

  And I choose "radio-returning"
  And I press "Next"

  And I choose "Prefer_Yes"
  And I press "Next"

  Then I press "Submit"
  Then I should see "Your form has been submitted. We will be sending out the results through email soon."
