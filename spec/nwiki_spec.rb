require_relative "./spec_helper"

describe Nwiki do
  subject{ last_response }

  context "when accessed '/'" do
    before do
      get "/"
    end
    it{ should be_ok }
  end

  # v0.1 now!
  context "when get data"
  context "given specify rootpath of data"
  context "when get data does not exist"

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
