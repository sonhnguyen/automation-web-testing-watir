When(/^I choose "([^"]*)" item on the popup$/) do |radioitem|
  @page.checkRadioButton_Click(radioitem)
end
