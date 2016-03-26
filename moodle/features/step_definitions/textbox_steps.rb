
When(/^I fill "([^"]*)" into "([^"]*)" textbox$/) do |content, txtbox|
  @page.checkTextBox_Elem(txtbox.strip).set content
end
