# -*- coding: utf-8 -*-
require "grit"
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
      tree = Grit::Repo.new(@data_file_directory).commits.first.tree
      case result = tree/file_path
      when Grit::Tree
        [200, {"Content-Type" => "text/html"}, ["<ul>" + result.contents.map(&:name).sort.map{ |n| %Q!<li><a href="#{n}">#{n}</a></li>! }.join("\n") + "</ul>"]]
      when Grit::Blob
        [200, {"Content-Type" => "text/html"}, [Orgmode::Parser.new(result.data.force_encoding('utf-8'), 1).to_html]]
      else
        [404, {"Content-Type" => "text/html"}, ["not found."]]
      end
    end

    def convert_file_path(str)
      path = str.
        gsub(%r!^#{@articles_url_prefix}!, '').
        gsub(%r!^/!, '').
        gsub(%r!/$!, '')
      path.empty? ? '/' : path
    end
  end
end
