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
        Grit::Repo.new(@data_file_directory).commits.map{ |history|
          history.diffs.map{ |diff|
            next nil if diff.deleted_file # FIXME how do we view deleted file?
            maker.items.new_item{ |item|
              path = diff.b_path.force_encoding('utf-8')
              item.link = "#{@site_link}#{@articles_url_prefix}/#{path}"
              item.title = File.basename(path)
              item.date = history.date
            }
          }.compact
        }.flatten
      end
      [200, {"Content-Type" => "text/xml"}, [feed.to_s]]
    end
  end
end
