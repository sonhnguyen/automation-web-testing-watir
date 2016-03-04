require "require_all"

require_relative "drivers/test-suite.rb"
require_all "tests/*.rb"

driver = TestSuite::TestDriver.instance

# TODO: setup to firefox.exe
driver.setupTest(:firefox, "C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe")
driver.runTests
driver.showTestStats
