module NewAssignmentDetailPageMod
  def self.createPage(assignname, db)
    assignid = db[:mdl_assign]
      .where('name = ?', assignname).first[:id]

    _NewAssignmentDetailPage = Class.new do
      require 'page-object'
      include PageObject

      page_url "http://localhost/moodle/assign/view.php?id=#{assignid}"

      def getLinkItemsList
        self.browser.links.map { |lnk| lnk.text }
      end

      def getPageNamePrefix
        self.browser.h2.text
      end

    end

    return _NewAssignmentDetailPage
  end
end
