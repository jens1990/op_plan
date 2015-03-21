Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^he submits invalid signin information$/ do
  click_button "Hier geht's hinein!"
end

Then /^he should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
end

When /^the user submits valid signin information$/ do
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Hier geht's hinein!"
end

Then /^he should see his profile page$/ do
  page.should have_selector('title', text: @user.name)
end

Then /^he should see a signout link$/ do
  page.should have_link('Logout', href: signout_path)
end



When /^the user clicks the logout link$/ do
  click_link "Logout"
end

Then /^he should see the home page$/ do
  page.should have_content("Transportplanung 1.1")
end


Then /^he should see a signin link$/ do
  page.should have_link('Login', href: signin_path)
end
