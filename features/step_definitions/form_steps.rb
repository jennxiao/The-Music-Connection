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
  when /^Student Name/
      field = "question[name]"
  when /^Phone Number/
    field = "question[phone]"
  when /^Email/
    field = "question[email]"
  when /^Address/
    field = "question[address]"
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
  when /^Grade/
    field = "question[grade]"
  when /^Parent Time Availability/
    field = "question[weekday][]"
  when /^Piano Home/
    field = "question[piano_home]"
  when /^Experience/
    field = "question[experiences]"
  when /^Past App/
    field = "question[pastapp]"
  when /^Lunch/
    field = "question[lunch]"
  when /^Parent Instrument/
    field = "question[instrument][]"
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
