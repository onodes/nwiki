# -*- coding: utf-8 -*-
require_relative "../spec_helper"

module Nwiki
  describe Articles do
    describe "functional test" do
      def app
        Rack::Lint.new(Nwiki::Articles.new('./spec/data'))
      end

      subject{ last_response }

      describe "get data" do
        context "when data exist" do
          context "when access a content" do
            before { get "/a_content" }
            it{ should be_ok }
            it{ subject.body.should == "<p class=\"title\">a content.</p>\n" }
          end
          context "when access other content" do
            before { get "/dir/other_content" }
            it{ should be_ok }
            it{ subject.body.should == "<p class=\"title\">日本語による別のコンテンツ.</p>\n" }
          end
        end
        context "when get data does not exist" do
          before { get "/blah_blah_blah" }
          it{ should be_not_found }
        end
        context "when access invalid path" do
          before { get "/../hoge" }
          it{ should be_forbidden }
        end
      end

      describe "get summary" do
        context "when access directory without slash" do
          before { get "/dir" }
          it{ should be_ok }
          it{ subject.body.should == "./dir/dir2/another_content\n./dir/other_content" }
        end
        context "when access directory with slash" do
          before { get "/dir/" }
          it{ should be_ok }
          it{ subject.body.should == "./dir/dir2/another_content\n./dir/other_content" }
        end
      end

      describe "markup" do
        context "given get org-mode" do
          before { get "/org-mode_content" }
          it { subject.body.should == "<h2 class=\"title\">ORG-HEADER</h2>\n<p>This is org-mode.</p>\n" }
        end
      end
    end

    describe "#convert_file_path" do
      subject{ Articles.new.convert_file_path path }
      context "given '/'" do
        let(:path){ "/" }
        it{ subject.should == "./" }
      end
      context "given '/a_content'" do
        let(:path){ "/a_content" }
        it{ subject.should == "./a_content" }
      end
      context "given '/a_content/'" do
        let(:path){ "/a_content/" }
        it{ subject.should == "./a_content" }
      end
      context "given '/dir/dir2/another_content'" do
        let(:path){ "/dir/dir2/another_content" }
        it{ subject.should == "./dir/dir2/another_content" }
      end
    end
  end
end
