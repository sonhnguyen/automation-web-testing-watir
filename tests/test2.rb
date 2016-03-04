#Include suite for testing
require_relative "../drivers/test-suite.rb"

#Some inheritance, must have here
class GitHubTest2 < TestSuite::TestCase

  def initialize
    super(
      "Testing filter by author opened pull requests function on Github",
      "https://github.com/atom/atom/pulls"
    )
  end

  #Should start at step 2
  def runTest(browser)
    puts "Step 2: Read all currently opened pull requests name and their author"
    pullrqs = []
    #Get a list of pullrq items
    def crawlPullRqs(prqs, browser)
      browser.lis(:class, "table-list-item").map { |prq|
        rqmeta = prq.div(:class, "issue-meta")
                    .span(:class, "issue-meta-section").text.split(" ")
        res = {
          pullrq_ID: rqmeta.first,
          pullrq_auth: rqmeta.last
        }
        res
      }.each do |item|
        prqs.push(item)
      end
    end

    #Visit each pagination links and collect all pullrq IDs and authors
    #crawlPullRqs(pullrqs, browser)
    _links = browser.div(:class, "pagination").links.map { |l| l.href }
    _links.pop
    _links.each do |url|
      browser.goto url
      crawlPullRqs(pullrqs, browser)
    end

    puts "Step 3: Click ‘Author’ dropdown list from the filter"
    browser.button(:text, "Author").click

    puts "Step 4: Wait until the list is populated"
    #Synchronize with AJAX loading
    while !browser.text_field(:id, "author-filter-field").exists? do sleep 0.1 end

    puts "Step 5: Click author name '50Wliu'"
    #Get 50Wliu link and click
    browser.links(:class, "select-menu-item").detect {|item|
      item.div(:class, "select-menu-item-text").text.split(" ")[0] == "50Wliu"
    }.click
    #Synchronize
    Watir::Wait.until {
      vvv = browser.text_field(:id, "js-issues-search").when_present.value.strip
      vvv == "is:open is:pr author:50Wliu"
    }

    puts "Step 6: Inspect the new list of opened pull requests"
    pullrqs_new = []
    crawlPullRqs(pullrqs_new, browser)

    puts "Expected Result:"
    puts "The new list of opened pull requests should only contains all and only pull requests of the selected filtered author"

    cond1 = (pullrqs_new.map {|prq| prq[:pullrq_auth] } - pullrqs.map {|prq| prq[:pullrq_auth] }).empty?
    cond2 = pullrqs_new.all? { |prq| prq[:pullrq_auth] == "50Wliu" }
    if cond1 and cond2 #Test passed condition here
      self.passed = true
      puts "TEST PASSED. The new list contains only and all pull requests of the filtered author"
    else    #Test failed condition here
      self.passed = false
      puts "TEST FAILED. Show what we have screwed up"
      reason = if !(pullrqs - pullrqs_new).empty?
        "Results does not contains all pull requests from 50Wliu: #{pullrqs - pullrqs_new}"
      else
        "Results contains at least 1 pull request author who is different from 50Wliu: #{pullrqs_new.map {|prq| prq[:pullrq_auth] }}"
      end
      puts reason
    end
  end
end
#Don't forget to add this line in the end
TestSuite::TestDriver.instance.data.push(GitHubTest2.new)
