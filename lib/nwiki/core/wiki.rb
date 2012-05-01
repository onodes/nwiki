module Nwiki
  module Core
    class Wiki
      def initialize path
        GitAccess.new(path)
      end
    end
  end
end
