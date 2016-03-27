
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
  begin
    @widgets[btnname].click
    sleep(3)
  rescue Selenium::WebDriver::Error::UnknownError
    ask("Seems like I cannot click on the button. Can you help me? Press Enter when you are done, so I can proceed")
  end
end
