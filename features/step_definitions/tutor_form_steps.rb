When "(I )fill in the tutor form with basic information" do
	steps %Q{
		And I fill in "Name" with "Anthony Zhou"
		And I fill in "Phone Number" with "847-873-2739"
		And I fill in "Email address" with "anthonyfzhou@berkeley.edu"
		And I fill in "SID" with "3032748539"
		And I fill in "Major" with "Computer Science"
		And I select "Tuesday" from "Time Availability" in tutor form
		And I check "K"
		And I press "Next"
		And I check "Violin"
		And I press "Next"
		And I select "Yes"
		And I press "Next"
		And I choose "Yes"
		And I press "Next"
		And I check "Member Commitment Policy"
		And I check "Attendance Policy"
		And I press "Next"
		And I choose "New"
		And I press "Next"
		And I press "Submit"
	}
end

When "(I )select {string} from {string} in tutor form" do |value, field|
  case field
  when "Time Availability"
    field = "question[weekday][]"
  when "Instrument/Singing"
    field = "question[instrument][]"
  when "In Class"
    field = "question[in_class]"
  when "Private Lessons?"
    field = "question[private]"
  when "Returning or New"
    field = "question[returning]"
  when "Prefer to work with previous student or class?"
    field = "question[prev_again]"
  when "Preferred Student/Class"
    field = "question[preferred_student_class]"
  when "Comments"
    field = "question[comment]"
  end
  
  select(value, :from => field)
end
