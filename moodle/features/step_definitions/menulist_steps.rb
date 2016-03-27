require 'pry'

When(/^I choose "([^"]*)" item on the popup$/) do |radioitem|
  binding.pry
  @page.checkRadioButton_Click(radioitem)
end
