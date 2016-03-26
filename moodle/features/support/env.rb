
if ENV["HEADLESS"] then
  require "celerity"
  browser = Celerity::Browser.new
  INDEX_OFFSET = 0
  WEBDRIVER = false
else
  require 'watir'
  require 'watir-webdriver'
  #TODO: (moodle) Setup web browser path here

  ENV["browser"] = "firefox" if ENV["browser"] == nil

  case ENV["browser"]
  when "firefox"
    download_directory = "#{Dir.pwd}/downloads"
    download_directory.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?

    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['browser.download.folderList'] = 2 # custom location
    profile['browser.download.dir'] = download_directory
    profile['browser.helperApps.neverAsk.saveToDisk'] = "text/csv,application/pdf"

    Selenium::WebDriver::Firefox.path= "/home/nthoang/Applications/firefox/firefox"
    browser = Watir::Browser.new :firefox, :profile => profile

  when "chrome"
    download_directory = "#{Dir.pwd}/downloads"
    download_directory.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?

    profile = Selenium::WebDriver::Chrome::Profile.new
    profile['download.prompt_for_download'] = false
    profile['download.default_directory'] = download_directory

    Selenium::WebDriver::Chrome.path= "/home/nthoang/Applications/firefox/firefox"
    browser = Watir::Browser.new :chrome, :profile => profile
  end

  INDEX_OFFSET = -1
  WEBDRIVER = true
end

require 'page-object/page_factory'
World(PageObject::PageFactory)

Before do
  @browser = browser
end

at_exit do
  browser.close
end
