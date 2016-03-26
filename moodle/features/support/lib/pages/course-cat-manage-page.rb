require 'page-object'
#require 'pry'
class CourseCategoryManagePage
  include PageObject
  page_url "http://localhost/moodle/course/management.php"

  def getCourseList
    brw = self.browser
    #binding.pry
    brw.links(:class, "float-left coursename").map { |linkitem|
      linkitem.text
    }
  end

end
