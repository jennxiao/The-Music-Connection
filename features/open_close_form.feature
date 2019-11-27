Feature: Open/close form
  As the TMC admin
  So that I can let my users know if TMC is accepting applications or not
  When I am on the home page
  I should see a link to applications if and only if I open the form

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
