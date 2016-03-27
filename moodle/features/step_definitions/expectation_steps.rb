require 'rspec/expectations'
require 'date'

Then(/^I should see "([^"]*)" option inside "([^"]*)" dropdown list$/) do |option, dropdownlst|
  expect(@page.checkDropdownListOptions(dropdownlst)).to include(option)
end

require 'pry'
Then(/^I should see "([^"]*)" date set by default in "([^"]*)" datepicker$/) do |date, datepicker|
  puts "Invalidate before going"
  binding.pry
  expect(@page.getDatefromDatePicker(datepicker)).to eq Date.today
end

Then(/^I should see "([^"]*)" link$/) do |lnk|
  linkitemslist = @page.getLinkItemsList
  expect(linkitemslist).to include(lnk)
end

Then(/^I should expect File "([^"]*)" Created in Feature: Course Content Management$/) do |filename|
  on AddAssignmentPage do |page|
      expect(page.getFileUploadedList).to include(filename)
      @page = page
      @GC << AssignAttachment.new(filename)
  end
end

Then(/^I should expect Assignment "([^"]*)" Created in Feature: Course Content Management$/) do |assignname|
  moduleitemslist = @page.getModuleItemList
  expect(moduleitemslist).to include(assignname)
  @GC << AssignmentItem.new(assignname)
end


Then(/^I should expect Course "([^"]*)" Created in Feature: Course Management$/) do |coursename|
  on CourseCategoryManagePage do |page|
    expect(page.getCourseList).to include(coursename)
    @page = page
    @GC << CourseItem.new(coursename)
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
  puts "\n" + errordesc
end

Then(/^I should be directed to a Page with prefix "([^"]*)"$/) do |pagename|
  case pagename
  when "Adding a new Assignment"
    on AddAssignmentPage do |page|
      expect(page.getPageNamePrefix).to eq(pagename)
      @page = page
    end
  when "New Assignment"
    on NewAssignmentDetailPageMod.createPage("New Assignment", @DB) do |page|
      expect(page.getPageNamePrefix).to eq(pagename)
      @page = page
    end
  else
    raise ArgumentError, "UNKNOWN Page name: '#{pagename}'"
  end
end

Then(/^I should be directed to "([^"]*)" Page$/) do |pagename|
  case pagename
  when "MockCourse"
    on(MockCoursePageMod.createPage("MockCourse", @DB)) do |page|
      expect(@page.current_url).to eq page.current_url
      @page = page
    end
  else
    raise ArgumentError, "UNKNOWN Page name: '#{pagename}'"
  end
end
