When(/^I click the first "([^"]*)" link$/) do |lnk|
  @page.checkLink_Click("first " + lnk)
end

When(/^I click "([^"]*)" link$/) do |lnk|
  @page.checkLink_Click(lnk)
end
