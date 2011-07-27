require "nwiki"

require "rack/test"

describe Nwiki do
  include Rack::Test::Methods

  def app
    Nwiki
  end

  subject{ last_response }

  context "when accessed '/'" do
    before do
      get "/"
    end
    it{ should be_ok }
  end
end
