require "org-ruby"

module Nwiki
  class Articles
    def initialize opt
      @data_file_directory = opt[:data_file_directory]
      @articles_url_prefix = opt[:articles_url_prefix]
    end

    def call env
      file_path = convert_file_path(env["PATH_INFO"])
      return [403, {"Content-Type" => "text/html"}, ["forbidden."]] if file_path.include? ".."
      Dir.chdir(@data_file_directory) do
        case
        when FileTest.directory?(file_path)
          search_dir = file_path + "/**/*"
          [200, {"Content-Type" => "text/html"}, [Dir.glob(search_dir).select{ |path| File.file?(path) }.sort.join("\n")]]
        when FileTest.file?(file_path)
          [200, {"Content-Type" => "text/html"}, [Orgmode::Parser.new(File.read(file_path), 1).to_html]]
        else
          [404, {"Content-Type" => "text/html"}, ["not found."]]
        end
      end
    end

    def convert_file_path(str)
      return './' if str == @articles_url_prefix
      '.' + str.gsub(/^#{@articles_url_prefix}/){ '' }.gsub(/\/$/){ '' }
    end
  end
end
