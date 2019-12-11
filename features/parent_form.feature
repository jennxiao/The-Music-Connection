Feature: Parent submits application
	As a parent
	So that I can enroll my child into the TMC program
	When I visit the TMC website
	I should be able to submit an application for my child

  Background: Parent visits home page first
    Given form is open
    And I am on the home page
    Then I am on the parent form

  @javascript
  Scenario: Parent submits application with valid parameters (happy path)
    And I fill in "Student Name" with "Anthony Zhou"
    And I fill in "Phone Number" with "847-873-2739"
    And I fill in "Email Address" with "anthonyfzhou@berkeley.edu"
    And I fill in "Address" with "10597 Stony Ridge Way"
    And I select "6" from "Grade"
    And I select "Tuesday" from "Parent Time Availability"
    And I press "Next"

    And I check "Violin"

    Then I press "Submit"
    Then I should see "Your form has been submitted. We will be sending out the results through email soon."
