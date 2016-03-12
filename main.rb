require "require_all"

require_relative "drivers/test-suite.rb"
require_all "tests/*.rb"

driver = TestSuite::TestDriver.instance

# TODO: setup to firefox.exe
driver.setupTest(:firefox, "/home/nthoang/Applications/firefox/firefox")
driver.runTests
driver.showTestStats
