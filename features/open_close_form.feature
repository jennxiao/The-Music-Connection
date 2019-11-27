Feature: Open/close form

Scenario: Form looks closed to users when the form is closed
Given form is closed
When I go to the home page
Then I should not see a link to "forms/teacher"
Then I should not see a link to "forms/tutor"
Then I should not see a link to "forms/parent"

Scenario: Form looks open to users when the form is open
Given form is open
When I go to the home page
Then I should see a link to "forms/teacher"
Then I should see a link to "forms/tutor"
Then I should see a link to "forms/parent"
