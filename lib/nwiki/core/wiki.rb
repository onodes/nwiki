module Nwiki
  module Core
    class Wiki
      def initialize path
        GitAccess.new(path)
      end

      def pages
        []
      end
    end
  end
end
