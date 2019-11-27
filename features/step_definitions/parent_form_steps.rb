When /^(?:|I )fill in the parent form with basic information/ do
	steps %Q{
		And I fill in "Student Name" with "Anthony Zhou"
		And I fill in "Phone Number" with "847-873-2739"
    And I fill in "Email Address" with "anthonyfzhou@berkeley.edu"
    And I fill in "Address" with "10597 Stony Ridge Way"
    And I select "6" from "Grade"
    And I select "Tuesday" from "Parent Time Availability"
    And I press "Next"
    And I select "No" from "Piano Home"
    And I select "Violin" from "Parent Instrument"
    And I select "1-2 years" from "Experience"
    And I select "No" from "Past App"
    And I select "No" from "Lunch"
	}
end
