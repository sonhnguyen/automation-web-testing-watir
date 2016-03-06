#Include suite for testing
require_relative "../drivers/test-suite.rb"
require 'spreadsheet'

#Some inheritance, must have here
class MailinatorTestCase < TestSuite::TestCase

  def initialize
    super(
      #Change here the title
      "Test If Mailinator CS423.softwaretesting mailbox contains mails",
      #Change the first url that we want to visit
      "http://www.mailinator.com/inbox2.jsp?public_to=cs423.softwaretesting#/#public_maildirdiv"
    )
  end

  #Should start at step 2
  #Step 1 is already go to the url specified above
  def runTest(browser)
    puts "Step 2: Open /tables/logins.xls file"
    book = Spreadsheet.open File.dirname(__FILE__) + '/..' + '/tables/checkemail.xls'
    #Open sheet 1
    sheet = book.worksheet 0
    sdtt_list = []
    #Now list all mails
    browser.div(:class, "someviewport").divs(:xpath, "//div[@onclick]").map { |rowdiv|
      coldivs = rowdiv.divs
      sdtt_list.push ({
        sender: coldivs[1].text.strip,
        title: coldivs[2].text.strip
      })
    }
    ntestfailed = 0
    ntestmalformed = 0
    #Starts at the second row
    puts "Step 3: Inside login.xlsx file, iteratively lookup all senders, title in the Sender, Title column and match with the ones retrived from the website"
    sheet.each 1 do |row|
      testrow = {
        sender: row[0].strip,
        title: row[1].strip,
        expected: row[2].strip
      }
      puts "\n\nON TEST INSTANCE:"
      puts testrow
      puts "Expected Result:"
      puts "If Expected is 'Contains this mail' then the mail with corresponding sender, title SHOULD appear in the website mailbox"
      puts "If Expected is 'Not Contain this mail' then the mail with corresponding sender, title SHOULD NOT appear in the website mailbox"
      found_in_mailbox = sdtt_list.any? { |mail|
         mail[:sender] == testrow[:sender] and
         mail[:title] == testrow[:title]
      }
      if found_in_mailbox and testrow[:expected] == "Contains this mail"
        puts "\n\nTEST PASSED: Found the mail #{ testrow } inside the mailbox"
      elsif not found_in_mailbox and testrow[:expected] == "Not Contain this mail"
        puts "\n\nTEST PASSED: Not found the mail #{ testrow } inside the mailbox"
      elsif not found_in_mailbox and testrow[:expected] == "Contains this mail"
        puts "\n\nTEST FAILED: Not found the mail while Expected is 'Contains this mail'"
        ntestfailed += 1
      elsif found_in_mailbox and testrow[:expected] == "Not Contain this mail"
        puts "\n\nTEST FAILED: Found the mail while Expected is 'Not Contains this mail'"
        ntestfailed += 1
      else
        puts "\n\nMALFORMED TEST TABLE-ROW: May happen if the Expected column not satisfied the TEST REQUIREMENT"
        puts "Skipping..."
        ntestmalformed += 1
      end
      #Do sth with row here
      #row[0] means first column of this row
      #The same applied for row[1] row[2], etc
      #cell = row[0] will assign cell to the content of the first row
      puts "Go back to Step 3 if not finished inputting the data"
    end

    #Simple TEST-TABLE Report
    puts "Has run all Test instance in the Table"
    puts "#{sheet.count - 1 - ntestfailed - ntestmalformed} Test instances PASSED"
    puts "#{ntestfailed} Test instances FAILED "
    puts "#{ntestmalformed} Test instances MALFORMED"

    self.passed = true
  end
end

#Don't forget to add this line in the end
TestSuite::TestDriver.instance.data.push(MailinatorTestCase.new)
