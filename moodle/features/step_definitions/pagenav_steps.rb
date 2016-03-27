require 'rspec/expectations'

Given(/^I am at "([^"]*)" Page$/) do |pagetitle|
  case pagetitle
  when "Add a new course"
    visit AddCoursePage do |page|
      @page = page
    end
  when "MockCourse"
    visit(MockCoursePageMod.createPage("MockCourse", @DB)) do |page|
      @page = page
    end
  else
    raise ArgumentError, "UNKNOWN Page: '#{pagetitle}'"
  end

end
