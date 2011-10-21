# -*- coding: utf-8 -*-
require_relative "../spec_helper"
require 'uri'

module Nwiki
  describe Articles do
    describe "functional test" do
      def app
        Rack::Lint.new(Articles.new(CONFIG))
      end

      subject{ last_response }

      describe "get data" do
        context "when data exist" do
          context "when access a content" do
            before { get "/articles/a_content" }
            it{ should be_ok }
            it{ subject["Content-Type"] == "text/html; charset=UTF-8" }
            it{ subject.body.should == "<!DOCTYPE html><html><head></head><body><p class=\"title\">a content.</p>\n</body></html>" }
          end
          context "when access other content" do
            before { get URI.escape("/articles/日本語ディレクトリ/日本語コンテント") }
            it{ should be_ok }
            it{ subject["Content-Type"] == "text/html; charset=UTF-8" }
            it{ subject.body.should == "<!DOCTYPE html><html><head></head><body><h2 class=\"title\">日本語コンテント</h2>\n</body></html>" }
          end
        end
        context "when get data does not exist" do
          before { get "/articles/blah_blah_blah" }
          it{ should be_not_found }
          it{ subject["Content-Type"] == "text/html; charset=UTF-8" }
        end
        context "when access invalid path" do
          before { get "/articles/../hoge" }
          it{ should be_forbidden }
          it{ subject["Content-Type"] == "text/html; charset=UTF-8" }
        end
      end

      describe "get summary" do
        context "when access directory without slash" do
          before { get "/articles/dir"; follow_redirect! }
          it{ last_request.url.should =~ %r!/articles/dir/$! }
          it{ should be_ok }
          it{ subject["Content-Type"] == "text/html; charset=UTF-8" }
          it{ subject.body.should == "<!DOCTYPE html><html><head></head><body><<ul><li><a href=\"dir2/\">dir2/</a></li>\n<li><a href=\"other_content\">other_content</a></li></ul></body></html>" }
        end
        context "when access directory with slash" do
          before { get "/articles/dir/" }
          it{ should be_ok }
          it{ subject["Content-Type"] == "text/html; charset=UTF-8" }
          it{ subject.body.should == "<!DOCTYPE html><html><head></head><body><<ul><li><a href=\"dir2/\">dir2/</a></li>\n<li><a href=\"other_content\">other_content</a></li></ul></body></html>" }
        end
      end

      describe "markup" do
        context "given get org-mode" do
          before { get "/articles/org-mode_content" }
          it{ subject["Content-Type"] == "text/html; charset=UTF-8" }
          it { subject.body.should == "<!DOCTYPE html><html><head></head><body><h2 class=\"title\">ORG-HEADER</h2>\n<p>This is org-mode.</p>\n</body></html>" }
        end
      end
    end

    describe "#convert_file_path" do
      subject{ Articles.new(CONFIG).convert_file_path path }
      context "given '/articles'" do
        let(:path){ "/articles" }
        it{ subject.should == "/" }
      end
      context "given '/articles/'" do
        let(:path){ "/articles/" }
        it{ subject.should == "/" }
      end
      context "given '/articles/a_content'" do
        let(:path){ "/articles/a_content" }
        it{ subject.should == "a_content" }
      end
      context "given '/articles/a_content/'" do
        let(:path){ "/articles/a_content/" }
        it{ subject.should == "a_content/" }
      end
      context "given '/articles/dir'" do
        let(:path){ "/articles/dir" }
        it{ subject.should == "dir" }
      end
      context "given '/articles/dir/'" do
        let(:path){ "/articles/dir/" }
        it{ subject.should == "dir/" }
      end
      context "given '/articles/dir/dir2/another_content'" do
        let(:path){ "/articles/dir/dir2/another_content" }
        it{ subject.should == "dir/dir2/another_content" }
      end
    end
  end
end
