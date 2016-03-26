require 'rspec/expectations'

Given(/^I am at "([^"]*)" Page$/) do |pagetitle|
  expect(["Add a new course"]).to include(pagetitle)

  case pagetitle
  when "Add a new course"
    visit AddCoursePage do |page|
      @page = page
    end
  end
end
