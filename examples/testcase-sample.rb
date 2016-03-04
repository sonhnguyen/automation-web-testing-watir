#Include suite for testing
require_relative "../drivers/test-suite.rb"

#Some inheritance, must have here
class SampleTestCase < TestSuite::TestCase

  def initialize
    super("Name and/or description of the testcase", "https://website.we.need.to.test")
  end

  #Should start at step 2
  def runTest(browser)
    puts "Step 2: At step description here"
    #Do shit here
    #....
    puts "Step 3: ...."
    #Do more shit here
    #....

    puts "Expected Result:"
    puts "Result that we expect to happen."

    if true #Test passed condition here
      self.passed = true
      puts "TEST PASSED. Add some description/details here"
    else    #Test failed condition here
      self.passed = false
      puts "TEST FAILED. Show what we have screwed up"
    end
  end
end

#Don't forget to add this line in the end, bitches
TestSuite::TestDriver.instance.data.push(SampleTestCase.new)
