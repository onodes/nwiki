require_relative "nwiki/version"
require "rack"
require "org-ruby"

module Nwiki
  ROOT_PATH = "."
  def self.call(env)
    path = strip_slash(env["PATH_INFO"])
    return [403, {"Content-Type" => "text/plain"}, ["forbidden."]] if path.include? ".."
    Dir.chdir(ROOT_PATH) do
      case
      when FileTest.directory?(path)
        search_dir = path + "/**/*"
        [200, {"Content-Type" => "text/plain"}, [Dir.glob(search_dir).select{ |path| File.file?(path) }.sort.join("\n")]]
      when FileTest.file?(path)
        [200, {"Content-Type" => "text/plain"}, [Orgmode::Parser.new(File.read(path)).to_html]]
      else
        [404, {"Content-Type" => "text/plain"}, ["not found."]]
      end
    end
  end

  def self.strip_slash(str)
    str.gsub(/^\//){ '' }.gsub(/\/$/){ '' }
  end
end
