module Nwiki
  module Core
    class Wiki
      def initialize path
        @access = GitAccess.new(path)
      end

      def pages
        if sha = @access.ref_to_sha('master')
          @access.tree(sha)
        else
          []
        end
      end

      def page page_name
        if page = self.pages.find { |page| page.path == page_name }
          Page.new(page)
        end
      end
    end
  end
end
