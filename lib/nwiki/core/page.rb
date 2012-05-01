module Nwiki
  module Core
    class Page
      def initialize blob
        @blob = blob
      end

      def filename
        @blob && @blob.name
      end

      def name
        File.basename(filename, '.*')
      end
    end
  end
end
