require "org-ruby"

module Nwiki
  class Articles
    def initialize root_path = "."
      @root_path = root_path
    end

    def call env
      file_path = convert_file_path(env["PATH_INFO"])
      return [403, {"Content-Type" => "text/plain"}, ["forbidden."]] if file_path.include? ".."
      Dir.chdir(@root_path) do
        case
        when FileTest.directory?(file_path)
          search_dir = file_path + "/**/*"
          [200, {"Content-Type" => "text/plain"}, [Dir.glob(search_dir).select{ |path| File.file?(path) }.sort.join("\n")]]
        when FileTest.file?(file_path)
          [200, {"Content-Type" => "text/plain"}, [Orgmode::Parser.new(File.read(file_path), 1).to_html]]
        else
          [404, {"Content-Type" => "text/plain"}, ["not found."]]
        end
      end
    end

    def convert_file_path(str)
      return './' if str == '/'
      '.' + str.gsub(/\/$/){ '' }
    end
  end
end
