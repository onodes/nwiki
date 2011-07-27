require_relative "../spec_helper"
module Nwiki
  describe "VERSION" do
    it{ VERSION.should_not be_nil }
  end
end
