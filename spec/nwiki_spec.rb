require_relative "./spec_helper"

describe Nwiki do
  subject{ last_response }

  context "when accessed '/'" do
    before do
      get "/"
    end
    it{ should be_ok }
  end
end
