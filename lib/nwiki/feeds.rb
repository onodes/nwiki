# -*- coding: utf-8 -*-
require 'rss'
require 'org-ruby'

module Nwiki
  class Feeds
    def initialize root_path = ".", path_prefix = "/feeds"
      @root_path = root_path
      @path_prefix = path_prefix
    end

    def call env
      feed = RSS::Maker.make("atom") do |maker|
        maker.channel.about = "http://niku.name/feeds/index"
        maker.channel.title = "ヽ（´・肉・｀）ノログ"
        maker.channel.description = "How do we fighting without fighting?"
        maker.channel.link = "http://niku.name/"
        maker.channel.author = "niku"
        maker.channel.date = Time.now
        maker.items.do_sort = true
        files.each{ |f|
          maker.items.new_item { |item|
            item.link = "http://niku.name/articles/#{f.path}"
            item.title = File.basename(f.path)
            item.date = f.mtime
          }
        }
      end
      [200, {"Content-Type" => "text/plain"}, [feed.to_s]]
    end

    def files
      Dir.chdir(@root_path) do
        Dir.glob('**/*').
          inject([]){ |m, p| File.file?(p) ? m + [File.new(p)] : m }.
          sort_by{ |f| f.mtime }.
          reverse
      end
    end
  end
end
