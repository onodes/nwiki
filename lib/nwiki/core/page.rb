module Nwiki
  module Core
    class Page
      def initialize blob
        @blob = blob
      end

      def name
        @blob && @blob.name
      end
    end
  end
end
