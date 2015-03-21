#encoding: UTF-8


Given /^a user visits the home page$/ do
  visit root_path
end

When /^he navigates to the help page$/ do
  click_link "Hilfe"
end

Then /^he should see the help page$/ do
  page.should have_content("Wenn Sie Hilfe brauchen")
end


Given /^a user visits the help page$/ do
  visit help_path
end

When /^he navigates to the about page$/ do
  click_link "Über uns"
end

Then /^he should see the about page$/ do
  page.should have_content("Im Kurs")
end
