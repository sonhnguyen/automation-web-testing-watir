module MockCoursePageMod
  def self.createPage(coursefullname, db)
    courseid = db[:mdl_course]
      .where('fullname = ?', coursefullname).first[:id]

    _MockCoursePage = Class.new do
      require 'page-object'
      include PageObject

      button(:turnEditOn, :value => "Turn editing on")
      button(:addResource, :class => "submitbutton")

      radio_button(:assignmentChoice, :id => "module_assign")

      page_url "http://localhost/moodle/course/view.php?id=#{courseid}"

      def getModuleItemList
        res = self.browser.spans(:class, "instancename").map { |moditem| moditem.text }
        res.delete_at(0)
        res
      end


      def checkRadioButton(btnname)
        case btnname
        when "Assignment"
          return self.assignmentChoice_element
        else
          raise ArgumentError, "UNKNOWN radio button name: '#{btnname}'"
        end
      end

      def checkRadioButton_Click(btnname)
        checkRadioButton(btnname).click
      end

      def checkButton(btnname)
        case btnname
        when "Turn editing on"
          return self.turnEditOn_element
        when "Add"
          return self.addResource_element
        #when "A Button icon which is a paper and a plus sign"

        else
          raise ArgumentError, "UNKNOWN button name: '#{btnname}'"
        end
      end

      def checkButton_Click(btnname)
        checkButton(btnname).click
        self.browser.wait
      end

      def getAddActivityOrResLink_Elem(offset = 0)
        #raise ArgumentError, "offset > 0 is not support" if offset > 0
        brw = self.browser
        brw.span(:class, "section-modchooser-link").links[offset]
      end

      def getModItemLink(offset = 0)
        brw = self.browser
        brw.spans(:class, "instancename")[offset]
      end

      def checkLink(linkname)
        case linkname
        when "first Add an activity or resource"
          return self.getAddActivityOrResLink_Elem
        when "New Assignment"
          return self.getModItemLink(1)
        else
          raise ArgumentError, "UNKNOWN link name: '#{btnname}'"
        end
      end

      def checkLink_Click(linkname)
        checkLink(linkname).click
        self.browser.wait
      end
    end

    return _MockCoursePage
  end
end
