When(/^I click the first "([^"]*)" link$/) do |lnk|
  @page.checkLink_Click("first " + lnk)
end
