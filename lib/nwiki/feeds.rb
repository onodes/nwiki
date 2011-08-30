# -*- coding: utf-8 -*-
require 'rss'
require 'org-ruby'

module Nwiki
  class Feeds
    def initialize opt
      @data_file_directory = opt[:data_file_directory]
      @feeds_url_prefix = opt[:feeds_url_prefix]
      @articles_url_prefix = opt[:articles_url_prefix]
      @site_title = opt[:site_title]
      @site_description = opt[:site_description]
      @site_link = opt[:site_link]
      @site_author = opt[:site_author]
    end

    def call env
      feed = RSS::Maker.make("atom") do |maker|
        maker.channel.about = @site_link + @feeds_url_prefix
        maker.channel.title = @site_title
        maker.channel.description = @site_description
        maker.channel.link = @site_link
        maker.channel.author = @site_author
        maker.channel.date = Time.now
        maker.items.do_sort = true
        files.each{ |f|
          maker.items.new_item { |item|
            item.link = "#{@site_link}#{@article_url_prefix}/#{f.path}"
            item.title = File.basename(f.path)
            item.date = f.mtime
          }
        }
      end
      [200, {"Content-Type" => "text/plain"}, [feed.to_s]]
    end

    def files
      Dir.chdir(@data_file_directory) do
        Dir.glob('**/*').
          inject([]){ |m, p| File.file?(p) ? m + [File.new(p)] : m }.
          sort_by{ |f| f.mtime }.
          reverse
      end
    end
  end
end
