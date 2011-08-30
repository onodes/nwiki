# -*- coding: utf-8 -*-
require_relative "../spec_helper"

module Nwiki
  describe Feeds do
    describe "functional test" do
      def app
        Rack::Lint.new(Nwiki::Feeds.new)
      end

      subject{ last_response }

      describe "get root" do
        before { get "/feeds/index" }
        it{ should be_ok }
      end
    end
  end
end
