module TestSuite
  # the Watir controller
  require "watir"
  require "watir-webdriver"

  class TestCase
    attr_reader :siteurl, :testname, :passed

    def initialize(testname, siteurl)
      @name = testname
      @siteurl = siteurl
    end

    def passed?
      @passed == true
    end

    def runTest(browser)
    end

    private
    def passed=(pa)
      raise "new passed value is not Boolean" unless [true, false].include? pa
      @passed = pa
    end
  end

  class TestDriver
    include Singleton

    attr_accessor :data
    attr_reader :browser

    def setupTest(browser, browserpath)
      raise "browserpath is not a string" unless browserpath.is_a? String
      raise "Unknown browser " + browser unless browser == :firefox or browser == :chrome
      Selenium::WebDriver::Firefox.path = browserpath
      @browser = Watir::Browser.new browser
    end

    def initialize
      @data = []
    end

    def runTests
      today = Time.now

      puts "TESTING TIME!!!"
      puts "TESTING ALL TEST-CASES from tests/*.rb"
      puts "at #{today}"
      puts "================================="
      for index in 0...self.data.length
        testcase = @data[index]
        puts "RUNNING TEST NO.#{index + 1}"
        puts "Step 1: Go to the test site: " + testcase.siteurl
        TestDriver.instance.browser.goto testcase.siteurl

        testcase.runTest(self.browser)
        puts "================================="
      end
      today = Time.now
      puts "ALL TEST-CASES HAS BEEN RUN"
      puts "Testing finished at: #{today}"
    end

    def showTestStats
      ptt = @data.each_with_index.map { |t, i| [t, i + 1] }
                 .partition { |tup| tup.first.passed? }
                 .map {|arr| arr.map { |tup| tup.last } }
      puts "#{ptt.first.length} TESTS PASSED: #{ptt.first}"
      puts "#{ptt.last.length} TESTS FAILED: #{ptt.last}"
    end
  end

end
