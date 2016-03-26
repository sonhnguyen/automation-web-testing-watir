require 'page-object'

class CourseCategoryItem < Struct.new(:name)
  def clean(db)
    db[:mdl_course_categories].where('name = ?', self.name).delete
  end
end

class AddCourseCategoryPage
  include PageObject

  text_field(:courseCategoryName, :id => 'id_name')
  button(:submit, :id => 'id_submitbutton')

  page_url "http://localhost/moodle/course/editcategory.php?parent=0"

  def createCourseCategoryMock(namestr)
    self.courseCategoryName = namestr
    self.submit
    self.browser.wait
    return CourseCategoryItem.new(namestr)
  end

end
