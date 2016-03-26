require 'page-object'

class LoginPage
  include PageObject

  select_list(:parentCategory, :id => 'id_parent')
  text_field(:categoryName, :id => 'id_name')
  div(:courseDescription, :id => 'id_description_editoreditable')

  page_url "http://localhost/moodle/course/modedit.php?add=quiz&type=&course=1&section=1&return=0&sr=0"

end
