require 'page-object'

class AssignAttachment < Struct.new(:filename)
  def clean(db)
    db[:mdl_files].where(filename: filename).delete
    db[:mdl_files].where(filename: ".", component: "mod_assign").delete
  end
end

class AssignmentItem < Struct.new(:assignname)
  def clean(db)
    db[:mdl_assign].where(name: assignname).delete
  end
end


class AddAssignmentPage
  include PageObject

  text_field(:assignmentName, :id => "id_name")
  link(:addAttachment, :title => "Add...")
  file_field(:fileUpload, :name => "repo_upload_file")
  button(:saveAndReturn, :id => "id_submitbutton2")

  def getPageNamePrefix
    self.browser.h2.text
  end

  def getFileUploadedList
    self.browser.divs(:class, "fp-filename").map {|fn| fn.text}
  end

  #page_url "http://localhost/moodle/course/modedit.php?add=quiz&type=&course=1&section=1&return=0&sr=0"

  def checkButton_Elem(btnname)
    case btnname
    when "Upload this file"
      target = self.browser.buttons(:class, "fp-upload-btn btn-primary btn").find { |btnelem|
        btnelem.text == "Upload this file"
      }
      return target
    when "Save and return to course"
      return self.saveAndReturn_element
    else
      raise ArgumentError, "UNKNOWN button name: '#{btnname}'"
    end
  end

  def checkButton_Click(btnname)
    checkButton_Elem(btnname).click
    sleep(3)
  end

  def checkFileField_Elem(filefldname)
    case filefldname
    when "Attachment"
      return self.fileUpload_element
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
