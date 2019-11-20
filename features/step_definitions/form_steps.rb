When(/^I fill the form with:$/) do | table |
  datas = table.hashes.first
  datas.each do |label, value|
    fill_in(label, :with => value)
  end
end

Then /^check to see if correct/ do
  save_and_open_page
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  case field

  when /^Email/
    field = "question[email]"
  when /^Name/
    field = "question[name]"
  when /^SID/
    field = "question[sid]"
  when /^Phone Number/
    field = "question[phone]"
  when /^Year/
    field = "question[year]"
  when /^Major/
    field = "question[major]"
  when /^Minor/
    field = "question[minor]"
  when /^Experiences/
    field = "question[exp]"
  when /^Teacher Name/
	field = "question[teacher_name]"
  end

  fill_in field, with: value
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  case field

  when /^Name/
    field = "question[name]"
  when /^Email/
    field = "question[email]"
  when /^Name/
    field = "question[name]"
  when /^SID/
    field = "question[sid]"
  when /^Phone Number/
    field = "question[phone]"
  when /^Year/
    field = "question[year]"
  when /^Major/
    field = "question[major]"
  when /^Minor/
    field = "question[minor]"
  when /^Experiences/
    field = "question[exp]"
  when /^Preferred Student/
    field = "question[preference]"
  when /^Teacher Name/
	field = "question[teacher_name]"
  when /^Class Name/
	  field = "question[class_name]"
  when /^School/
	field = "question[school_name]"
  when /^Other/
	field = "other_instrument"
  end
  
  fill_in field, with: value
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  case field

  when /^Experiences/
    field = "question[exp]"
  when /^Time Availability/
    field = "question[time]"
  when /^Instrument/
    field = "question[instrument]"
  when /^Class Time/
	field = "question[weekday][]"
  end
  
  select(value, :from => field)
end

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
