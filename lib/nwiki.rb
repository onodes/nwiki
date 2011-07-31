require "rack"
require_relative "nwiki/version"

module Nwiki
  ROOT_PATH = "."
  def self.call(env)
    path = strip_slash(env["PATH_INFO"])
    return [403, {"Content-Type" => "text/plain"}, ["forbidden."]] if path.include? ".."
    Dir.chdir(ROOT_PATH) do
      case
      when FileTest.file?(path)
        [200, {"Content-Type" => "text/plain"}, [File.read(path)]]
      when FileTest.directory?(path)
        search_dir = path + "/**/*"
        [200, {"Content-Type" => "text/plain"}, [Dir.glob(search_dir).select{ |path| File.file?(path) }.sort.join("\n")]]
      else
        [404, {"Content-Type" => "text/plain"}, ["not found."]]
      end
    end
  end

  def self.strip_slash(str)
    str.gsub(/^\//){ '' }.gsub(/\/$/){ '' }
  end
end
