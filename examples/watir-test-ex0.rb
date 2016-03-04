# the Watir controller
require "watir"
require 'watir-webdriver'

# set a variable
test_site = "http://www.google.com"

# TODO: setup firefox
Selenium::WebDriver::Firefox.path= "/home/nthoang/Applications/firefox/firefox"
browser = Watir::Browser.new :firefox

# TODO: setup chrome
#Selenium::WebDriver::Chrome.path= "..."
#browser = Watir::Browser.new :chrome


# print some comments
puts "Beginning of test: Google search."

puts " Step 1: go to the test site: " + test_site
browser.goto test_site

puts " Step 2: enter 'pickaxe' in the search text field."
browser.text_field(:name, "q").set "pickaxe" # "q" is the name of the search field

puts " Step 3: click the 'Google Search' button."
browser.button(:name, "btnG").click # "btnG" is the name of the Search button

puts " Expected Result:"
puts "  A Google page with results should be shown. 'Programming Ruby' should be high on the list."

puts " Actual Result:"
if browser.text.include? "Programming Ruby"
  puts "  Test Passed. Found the test string: 'Programming Ruby'. Actual Results match Expected Results."
else
  puts "  Test Failed! Could not find: 'Programming Ruby'."
end

puts "End of test: Google search."
