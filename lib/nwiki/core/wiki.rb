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
        nil
      end
    end
  end
end
