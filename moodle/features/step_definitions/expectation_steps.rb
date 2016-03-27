require 'rspec/expectations'
require 'date'

Then(/^I should see "([^"]*)" option inside "([^"]*)" dropdown list$/) do |option, dropdownlst|
  expect(@page.checkDropdownListOptions(dropdownlst)).to include(option)
end

Then(/^I should see "([^"]*)" date set by default in "([^"]*)" datepicker$/) do |date, datepicker|
  expect(["today"]).to include(date)
  expect(@page.getDatefromDatePicker(datepicker)).to eq Date.today
end

Then(/^I should expect Course "([^"]*)" Created in Feature: Course Management$/) do |coursename|
  on CourseCategoryManagePage do |page|
    @page = page
    @GC << CourseItem.new(coursename)
    expect(@page.getCourseList).to include(coursename)
  end
end

Then(/^I should expect User Error \#(\d+) in Feature: Course Management$/) do |errid|
  errordesc = @errors["Error ##{errid}"]
  case errid
  when '1' #"A User Error: Course full name and Course short name field must not be empty"
    expect(@page).to have_errorFullNameMissing.and have_errorShortNameMissing
    expect(@page.errorFullNameMissing).to eq("Missing full name")
    expect(@page.errorShortNameMissing).to eq("Missing short name")
  when '2' #"A User Error: Database has been used as short name"
    expect(@page).to have_errorShortNameAlrdyUsed
    expect(@page.errorShortNameAlrdyUsed).to eq("Short name is already used for another course (Database)")
  else
    raise ArgumentError, "UNKNOWN Error ##{errid}"
  end
  puts errordesc
end

Then(/^I should be directed to a Page with prefix "([^"]*)"$/) do |pagename|

  on AddAssignmentPage do |page|
    @page = page
    expect(@page.getPageNamePrefix).to eq(pagename)
  end
end
