When /^(?:|I )log in as admin/ do
	steps %{
		And I am on the home page
		And I am on the admin page
		And I fill in "password" with "password"
		And I press "Submit"
	}
end
