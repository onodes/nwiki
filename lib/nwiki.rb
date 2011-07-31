require "rack"
require_relative "nwiki/version"

module Nwiki
  ROOT_PATH = "."
  def self.call(env)
    return [403, {"Content-Type" => "text/plain"}, ["forbidden."]] if env["PATH_INFO"].include? ".."
    begin
      [200, {"Content-Type" => "text/plain"}, [File.read(ROOT_PATH + env["PATH_INFO"])]]
    rescue => ex
      if ex.message =~ /^No such file or directory/
        [404, {"Content-Type" => "text/plain"}, ["not found."]]
      else
        Dir.chdir(ROOT_PATH) do
          search_dir = "#{env['PATH_INFO'].gsub(/^\//){ '' }}/**/*"
          [200, {"Content-Type" => "text/plain"}, [Dir.glob(search_dir).select{ |path| File.file?(path) }.sort.join("\n")]]
        end
      end
    end
  end
end
