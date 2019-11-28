When /^(?:|I )fill in class "(.*)" with basic information/ do |class_num|
	steps %Q{
		And I fill in "Teacher Name" with "Anthony Zhou"
		And I fill in "Phone Number" with "847-873-2739"
		And I fill in "Email Address" with "anthonyfzhou@berkeley.edu"
		And I press "Next"
		And I fill in Class "#{class_num}" "Class Name" with "Example Class"
		And I fill in Class "#{class_num}" "School" with "Berkeley Elementary"
		And I select Class "#{class_num}" "Monday" from "Class Time"
	}
end

