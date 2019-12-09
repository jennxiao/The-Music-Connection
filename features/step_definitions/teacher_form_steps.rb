When /^(?:|I )fill in the teacher form with basic information/ do
	steps %Q{
		And I fill in "Teacher Name" with "Anthony Zhou"
		And I fill in "Phone Number" with "847-873-2739"
		And I fill in "Email Address" with "anthonyfzhou@berkeley.edu"
		And I press "Next"
	}
end

When /^(?:I )fill in class "(.*)" with basic information/ do |class_num|
	steps %Q{
		And I fill in class "#{class_num}" "Class Name" with "Example Class"
		And I fill in class "#{class_num}" "School" with "Berkeley Elementary"
		And I select class "#{class_num}" "Monday" from "Time Availability"
	}
end

#Steps for type input areas
When /^(?:|I )fill in class "(.*)" "([^"]*)" with "([^"]*)"$/ do |class_num, field, value|

  case field
	  
  when /^Class Name/
	  field = "question" + class_num + "[class_name]"
  when /^School/
	  field = "question" + class_num + "[school_name]"
  when /^Other/
	  field = "other_instrument" + class_num
  end
  
  fill_in field, with: value
end
  
#Steps for checkbox areas
When /^(?:|I )check class "(.*)" "([^"]*)"$/ do |class_num, field|
  check(field + class_num)
end

#Steps for dropdown areas
When /^(?:|I )select class "(.*)" "([^"]*)" from "([^"]*)"$/ do |class_num, value, field|
  case field

  when /^Time Availability/
    field = "question" + class_num + "[weekday][]"
  end
  
  select(value, :from => field)
end
