require 'page-object'

class LoginPage
  include PageObject

  text_field(:username, :id => 'username')
  text_field(:password, :id => 'password')
  button(:login, :id => 'loginbtn')
  button(:logout, :value => 'Log out')

  page_url "http://localhost/moodle/login/index.php"

end
