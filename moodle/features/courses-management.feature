@coursecontentmanage-feat-cleanup
Feature: Course Management

Background:
  Given I have logged in as Admin
  And I have created "CS" Course Category
  And I have created Course with short name "Database" and full name "Database"
  And I am at "Add a new course" Page

Scenario: User visits "Add a new course" section and check the "Course Category" dropdown list
  Then I should see "CS" option inside "Course category" dropdown list

Scenario: User visits "Add a new course" section and check the default date
  Then I should see "today" date set by default in "Course start date" datepicker

Scenario Outline: User wants to create a new Course
  Given the user error: "Error #1" means "A User Error: Course full name and Course short name field must not be empty"
  And the user error: "Error #2" means "A User Error: Database has been used as short name"

  When I fill "<Course full name>" into "Course full name" textbox
  And I fill "<Course short name>" into "Course short name" textbox
  And I choose "<Course category>" in "Course category" dropdown list
  And I click "Save and return to course" button
  Then I should expect <Expected> in Feature: Course Management
  Examples:
  | Course full name | Course short name | Course category | Expected                  |
  | b                | a                 | CS              | Course "b" Created        |
  |                  |                   | Miscellaneous   | User Error #1             |
  | b                | Database          | Miscellaneous   | User Error #2             |
  | Database         | b                 | Miscellaneous   | Course "Database" Created |
