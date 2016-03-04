require_relative "../drivers/test-suite.rb"

class GitHubTest1 < TestSuite::TestCase

  def initialize
    super("Testing visibility of atom/atom repo on Github", "https://github.com")
  end

  def runTest(browser)
    puts "Step 2: Type ‘atom’ on the textbox with a placeholder ‘Search Github’. Press enter"
    browser.text_field(:name, "q").set "atom"
    browser.send_keys :enter

    firstitem = browser.lis(:class, "repo-list-item public source").first
    reponame, repodesc =
      firstitem.h3(:class, "repo-list-name").text,
      firstitem.p(:class, "repo-list-description").text

    puts "Expected Result:"
    puts "atom/atom The hackable text editor should appear as the first item of the result list.\n"

    if reponame == "atom/atom" and repodesc == "The hackable text editor"
      self.passed = true
      puts "TEST PASSED. Found 'atom/atom The hackable text editor as the first item of the list'"
    else
      self.passed = false
      puts "TEST FAILED. No 'atom/atom. The hackable text editor appeared as the first item of the list'"
    end
  end
end

TestSuite::TestDriver.instance.data.push(GitHubTest1.new)
