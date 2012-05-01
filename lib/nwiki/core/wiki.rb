module Nwiki
  module Core
    class Wiki
      def initialize path
        GitAccess.new(path)
      end

      def pages
        []
      end

      def page page_name
        nil
      end
    end
  end
end
