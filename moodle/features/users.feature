Feature: Users Management
  Add User
  View Users
  Delete User
  Update User

Scenario: Filling in User Info form in Moodle

Given I has logged into the system
And I has clicked 'Add a new user' link on the left bar
When I
Then $20 should be dispensed
