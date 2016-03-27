When(/^I choose file "([^"]*)" in the "([^"]*)" filechooser$/) do |filename, filechse|
  filechooser = @page.checkFileField_Elem(filechse)
  filepath = ENV["uploadpath"] + "/#{filename}"
  filepath.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?

  filechooser.set filepath
  @GC << AssignAttachment.new(filename)
end
