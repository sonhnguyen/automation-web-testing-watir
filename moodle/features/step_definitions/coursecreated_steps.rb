Given(/^I have created "([^"]*)" Course Category$/) do |coursecat|
  visit AddCourseCategoryPage do |page|
    @GC << page.createCourseCategoryMock(coursecat)
  end
end

Given(/^I have created Course with short name "([^"]*)" and full name "([^"]*)"$/) do |shortnm, fullnm|
  visit AddCoursePage do |page|
    @GC << page.createCourseMock(fullnm, shortnm)
  end
end
