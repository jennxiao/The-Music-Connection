Given "form is {word}" do | word |
  state = false
  if word == "open"
    state = true
  end
  settings = AdminSettings.last
  if settings.nil?
    settings = AdminSettings.new
    settings.attributes = {
      form_open: false,
      salt: "salt",
      password_hash: BCrypt::Password.create('password'),
      last_updated: Time.at(1),
      email: 'placeholder@tmc.com',
      session_id: 'placeholder'
    }
  end
  a = AdminSettings.new
  a.attributes = {
    form_open: state,
    salt: settings.salt,
    password_hash: settings.password_hash,
    last_updated: settings.last_updated,
    email: settings.email,
    session_id: settings.session_id
  }
  a.save
end

Then "I should see a link to {string}" do | link |
  page.should have_link(href: link)
end

Then "I should not see a link to {string}" do | link |
  page.should_not have_link(href: link)
end

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
  
  save_and_open_page 
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
