When /^(?:|I )fill in the teacher form with basic information/ do
	steps %Q{
		And I fill in "Teacher Name" with "Anthony Zhou"
		And I fill in "Phone Number" with "847-873-2739"
		And I fill in "Email Address" with "anthonyfzhou@berkeley.edu"
		And I press "Next"
		And I fill in "Class Name" with "Example Class"
		And I fill in "School" with "Berkeley Elementary"
		And I select "Monday" from "Class Time"
	}
end
