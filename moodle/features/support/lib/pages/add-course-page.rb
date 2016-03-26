require 'page-object'
require 'date'
#require 'pry'

class CourseItem < Struct.new(:fullname)
  def clean(db)
    db[:mdl_course].where('fullname = ?', self.fullname).delete
  end
end

class AddCoursePage
  include PageObject

  text_field(:courseFullName, :id => 'id_fullname')
  text_field(:courseShortName, :id => 'id_shortname')
  select_list(:courseCategory, :id => 'id_category')
  select_list(:courseStartDay, :id => 'id_startdate_day')
  select_list(:courseStartMonth, :id => 'id_startdate_month')
  select_list(:courseStartYear, :id => 'id_startdate_year')
  button(:submitReturn, :id => 'id_saveandreturn')

  span(:errorFullNameMissing, :id => 'id_error_fullname')
  span(:errorShortNameMissing, :id => 'id_error_shortname')
  span(:errorShortNameAlrdyUsed, :class => 'error')

  page_url "http://localhost/moodle/course/edit.php?category=1&returnto=catmanage"

  def has_errorShortNameAlrdyUsed?
    return self.errorShortNameAlrdyUsed_element.exists?
  end

  def has_errorFullNameMissing?
    return self.errorFullNameMissing_element.exists?
  end

  def has_errorShortNameMissing?
    return self.errorShortNameMissing_element.exists?
  end

  def getDatefromDatePicker(datepicker)
    Date.strptime("#{self.courseStartDay}#{self.courseStartMonth}#{self.courseStartYear}","%d%B%Y")
  end

  def createCourseMock(fullname, shortname)
    self.courseFullName = fullname
    self.courseShortName = shortname
    self.submitReturn
    self.browser.wait
    return CourseItem.new(fullname)
  end

  def checkTextBox_Elem(txtboxname)
    case txtboxname
    when "Course full name"
      return self.courseFullName_element
    when "Course short name"
      return self.courseShortName_element
    else
      raise ArgumentError, "UNKNOWN textbox name: #{txtboxname}"
    end
  end

  def checkTextBox(txtboxname)
    case txtboxname
    when "Course full name"
      return self.courseFullName
    when "Course short name"
      return self.courseShortName
    else
      raise ArgumentError, "UNKNOWN textbox name: #{txtboxname}"
    end
  end

  def checkButton(btnname)
    case btnname
    when "Save and return to course"
      return self.submitReturn_element
    else
      raise ArgumentError, "UNKNOWN button name: #{btnname}"
    end
  end

  def checkButton_Click(btnname)
    checkButton(btnname).click
    self.browser.wait
    #binding.pry
  end

  def checkDropdownList(lstname)
    if (lstname == "Course category")
      return self.courseCategory
    else
      raise ArgumentError, "UNKNOWN dropdownList name: #{lstname}"
    end
  end

  def checkDropdownList_Elem(lstname)
    if (lstname == "Course category")
      return self.courseCategory_element
    else
      raise ArgumentError, "UNKNOWN dropdownList name: #{lstname}"
    end
  end

  def checkDropdownListOptions(lstname)
    if (lstname == "Course category")
    #  binding.pry
      return self.courseCategory_options
    else
      raise ArgumentError, "UNKNOWN dropdownList name: #{lstname}"
    end
  end

end
