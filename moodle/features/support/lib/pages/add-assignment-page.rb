require 'page-object'

class AddAssignmentPage
  include PageObject

  text_field(:assignmentName, :id => "id_name")
  div(:addAttachment, :class => "dndupload-arrow")
  file_field(:fileUpload, :name => "repo_upload_file")

  def getPageNamePrefix
    self.browser.h2.text
  end

  #page_url "http://localhost/moodle/course/modedit.php?add=quiz&type=&course=1&section=1&return=0&sr=0"

  def checkFileField_Elem(filefldname)
    case filefldname
    when "Attachment"
      return self.addAttachment_element
    else
      raise ArgumentError, "UNKNOWN file field name: '#{filefldname}'"
    end
  end

  def checkTextBox_Elem(txtboxname)
    case txtboxname
    when "Assignment name"
      return self.assignmentName_element
    else
      raise ArgumentError, "UNKNOWN textbox name: '#{txtboxname}'"
    end
  end

  def checkTextBox(txtboxname)
    case txtboxname
    when "Assignment name"
      return self.assignmentName
    else
      raise ArgumentError, "UNKNOWN textbox name: '#{txtboxname}'"
    end
  end
end
