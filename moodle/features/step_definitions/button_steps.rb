
When(/^I click "([^"]*)" button$/) do |btn|
  @page.checkButton_Click(btn.strip)
end

Given(/^the button description: "([^"]*)" describes "([^"]*)"$/) do |btnname, btndesc|
  @widgets = {} if not defined? @widgets
  @widgets[btnname] = case btndesc
  when "A Button icon which is a paper and a plus sign"
    @page.addAttachment_element
  else
    raise ArgumentError, "UNKNOWN button description: '#{btndesc}'"
  end
end

When(/^I click "([^"]*)" button as described$/) do |btnname|
  #@page.browser.driver.execute_script("window.scrollBy(0,255)")
  #sleep(3)
  @widgets[btnname].click
end
