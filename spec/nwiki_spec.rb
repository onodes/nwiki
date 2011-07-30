# -*- coding: utf-8 -*-
require_relative "./spec_helper"

describe Nwiki do
  Nwiki::ROOT_PATH = "spec/data" # FIXME

  subject{ last_response }

  # v0.1 now!
  describe "get data" do
    context "when data exist" do
      context "when access a content" do
        before do
          get "/a_content"
        end
        it{ should be_ok }
        it{ subject.body.should == "a content." }
      end
      context "when access other content" do
        before do
          get "/dir/other_content"
        end
        it{ should be_ok }
        it{ subject.body.should == "日本語による別のコンテンツ." }
      end
    end
    context "when get data does not exist" do
      before do
        get "/blah_blah_blah"
      end
      it{ should be_not_found }
    end
  end

  # v0.2
  context "when access summary"
  context "when access feed"

  # v0.3
  context "given get some type"
  context "given get org-mode data"

  # TODO
  context "given get data include image path"
  context "when search data"
  context "when search tag"
  context "given specify css"
  context "when post data"
  context "given add plugin"
end
