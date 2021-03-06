# frozen_string_literal: true

When /^(?:|I )fill in the teacher form with basic information/ do
  steps %(
		And I fill in "Teacher Name" with "Anthony Zhou"
		And I fill in "Phone Number" with "847-873-2739"
		And I fill in "Email Address" with "anthonyfzhou@berkeley.edu"
		And I press "Next"
	)
end

When /^(?:|I )fill out the teacher form/ do
	steps %{
		And I fill in "Teacher Name" with "Teacher Anthony Zhou"
		And I fill in "Phone Number" with "222-222-2222"
		And I fill in "Email Address" with "Teacher@berkeley.edu"
		And I press "Next"
		
		Then I fill in class "0" with basic information
		And I check class "0" "K"
		And I check class "0" "Piano"
		Then I press "Submit"
	}
end

When /^(?:I )fill in class "(.*)" with basic information/ do |class_num|
  steps %(
		And I fill in class "#{class_num}" "Class Name" with "Example Class"
		And I fill in class "#{class_num}" "School" with "Berkeley Elementary"
		And I select class "#{class_num}" "Monday" from "Time Availability"
	)
end

# Steps for type input areas
When /^(?:|I )fill in class "(.*)" "([^"]*)" with "([^"]*)"$/ do |class_num, field, value|
  case field

  when /^Class Name/
    field = 'question' + class_num + '[class_name]'
  when /^School/
    field = 'question' + class_num + '[school_name]'
  when /^Other/
    field = 'other_instrument' + class_num
  end

  fill_in field, with: value
end

# Steps for checkbox areas
When /^(?:|I )check class "(.*)" "([^"]*)"$/ do |class_num, field|
  check(field + class_num)
end

# Steps for dropdown areas
When /^(?:|I )select class "(.*)" "([^"]*)" from "([^"]*)"$/ do |class_num, value, field|
  case field

  when /^Time Availability/
    field = 'question' + class_num + '[weekday][]'
  end

  select(value, from: field)
end
