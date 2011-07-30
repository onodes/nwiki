require "rack"
require_relative "nwiki/version"

module Nwiki
  ROOT_PATH = "."
  def self.call(env)
    begin
      [200, {"Content-Type" => "text/plain"}, [File.read(ROOT_PATH + env["PATH_INFO"])]]
    rescue
      [404, {"Content-Type" => "text/plain"}, ["not found."]]
    end
  end
end
