When(/^I choose file "([^"]*)" in the "([^"]*)" filechooser$/) do |filename, filechse|
  filechooser = @page.checkFileField_Elem(filechse)
  filepath = ENV["uploadfolder"] + "/#{filename}"
  filepath.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
  filechooser.set filepath
end
