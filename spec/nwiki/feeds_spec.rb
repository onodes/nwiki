# -*- coding: utf-8 -*-
require_relative "../spec_helper"

module Nwiki
  describe Feeds do
    describe "functional test" do
      def app
        Rack::Lint.new(Feeds.new(CONFIG))
      end

      subject{ last_response }

      describe "get root" do
        before { get "/feeds/index" }
        let(:rss){ RSS::Parser.parse(subject.body) }
        it{ should be_ok }
        it{ rss.should_not be_nil }
      end
    end
  end
end
