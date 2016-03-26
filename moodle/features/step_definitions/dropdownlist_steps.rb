When(/^I choose "([^"]*)" in "([^"]*)" dropdown list$/) do |item, dropdownlst|
  begin
    @page.checkDropdownList_Elem(dropdownlst.strip).select item
  rescue Watir::Exception::NoValueFoundException
    puts "FOUND NO #{item} in #{dropdownlst} dropdownlist, SKIPPED"
  end
end
