def login_as(page, username, password)
  page.browser.wait
  if page.logout_element.exists?
    page.logout
    page.browser.wait
  end
  page.username_element.when_present.set username
  page.password_element.when_present.set password
  page.login
  page.browser.wait
end

def login_asAdmin(page)
  login_as(page, "tester", "Testertester1*")
end

Given(/^I have logged in as Admin$/) do
  visit LoginPage do |page|
    login_asAdmin(page)
  end
end
