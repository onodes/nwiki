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
        describe "each item" do
          specify "link should match with http://niku.name/articles" do
            rss.items.map{ |item| item.link.href =~ /http:\/\/niku\.name\/articles\// }.should be_all
          end
        end
      end
    end
  end
end
