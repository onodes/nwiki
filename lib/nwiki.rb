require "rack"
require_relative "nwiki/version"

module Nwiki
  ROOT_PATH = "."
  def self.call(env)
    return [403, {"Content-Type" => "text/plain"}, ["forbidden."]] if env["PATH_INFO"].include? ".."
    begin
      [200, {"Content-Type" => "text/plain"}, [File.read(ROOT_PATH + env["PATH_INFO"])]]
    rescue
      [404, {"Content-Type" => "text/plain"}, ["not found."]]
    end
  end
end
