@cleanup
Feature: Course Content Management

Background:
  Given I have logged in as Admin
  And I have created Course with short name "MockCourse" and full name "MockCourse"
  And I am at "MockCourse" Page

Scenario: User wants to upload an assignment
  When I click "Turn editing on" button
  And I click the first "Add an activity or resource" link
  And I choose "Assignment" item on the popup
  And I click "Add" button
  Then I should be directed to a Page with prefix "Adding a new Assignment"
  And I fill "New Assignment" into "Assignment name" textbox
  Given the button description: "Add attachment" describes "A Button icon which is a paper and a plus sign"
  When I click "Add attachment" button as described
  And I choose file "sss.txt" in the "Attachment" filechooser
  And I click "Upload this file" button
  Then I should expect File "sss.txt" Created in Feature: Course Content Management
  And I click "Save and return to course" button
  And I should be directed to "MockCourse" Page
  Then I should expect Assignment "New Assignment" Created in Feature: Course Content Management
  When I click "New Assignment" link
  Then I should be directed to a Page with prefix "New Assignment"
  And I should see "sss.txt" link
