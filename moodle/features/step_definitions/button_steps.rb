When(/^I click "([^"]*)" button$/) do |btn|
  @page.checkButton_Click(btn.strip)
end
