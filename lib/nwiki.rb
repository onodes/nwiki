require "rack"
require_relative "nwiki/version"

module Nwiki
  def self.call(env)
    [200, {"Content-Type" => "text/plain"}, ["Hello, nwiki, VERSION:#{VERSION}"]]
  end
end
