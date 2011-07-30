require "rack"
require_relative "nwiki/version"

module Nwiki
  ROOT_PATH = "."
  def self.call(env)
    body = File.read(ROOT_PATH + env['PATH_INFO']) rescue nil
    [200, {"Content-Type" => "text/plain"}, [body || '']]
  end
end
