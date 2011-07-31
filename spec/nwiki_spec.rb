# -*- coding: utf-8 -*-
require_relative "./spec_helper"

describe Nwiki do
  Nwiki::ROOT_PATH = "spec/data" # FIXME

  subject{ last_response }

  # v0.1 now!
  describe "get data" do
    context "when data exist" do
      context "when access a content" do
        before { get "/a_content" }
        it{ should be_ok }
        it{ subject.body.should == "a content." }
      end
      context "when access other content" do
        before { get "/dir/other_content" }
        it{ should be_ok }
        it{ subject.body.should == "日本語による別のコンテンツ." }
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

  # v0.2
  describe "get summary" do
    context "when access directory without slash" do
      before { get "/dir" }
      it{ should be_ok }
      it{ subject.body.should == "dir/dir2/another_content\ndir/other_content" }
    end
    context "when access directory with slash" do
      before { get "/dir/" }
      it{ should be_ok }
      it{ subject.body.should == "dir/dir2/another_content\ndir/other_content" }
    end
  end
  context "when access feed"

  # v0.3
  context "given get some type"
  context "given get org-mode data"

  # TODO
  context "when configure data path"
  context "given get data include image path"
  context "when search data"
  context "when search tag"
  context "given specify css"
  context "when post data"
  context "given add plugin"
end
