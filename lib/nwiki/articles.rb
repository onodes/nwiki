# -*- coding: utf-8 -*-
require "grit"
require "org-ruby"

module Nwiki
  class Articles
    def initialize opt
      @data_file_directory = opt[:data_file_directory]
      @articles_url_prefix = opt[:articles_url_prefix]
      @file_encoding = opt[:file_encoding]
    end

    def call env
      file_path = convert_file_path(env["PATH_INFO"])
      return [403, {"Content-Type" => "text/plane"}, ["forbidden."]] if file_path.include? ".."
      tree = Grit::Repo.new(@data_file_directory).commits.first.tree
      case result = tree/file_path
      when Grit::Tree
        if env["PATH_INFO"] =~ /\/$/
          list = "<ul>" + result.contents.map{ |c|
            case c
            when Grit::Tree
              %Q!<li><a href="#{c.name}/">#{c.name}/</a></li>!
            when Grit::Blob
              %Q!<li><a href="#{c.name}">#{c.name}</a></li>!
            else
              # TODO
            end
          }.sort.join("\n") + "</ul>"
          [200, {"Content-Type" => "text/html; charset=#{@file_encoding}"}, [wrap_html{ list }]]
        else
          request_path = env["SCRIPT_NAME"] + env["PATH_INFO"]
          [301, {"Content-Type" => "text/plane; charset=#{@file_encoding}", "Location" => request_path + "/"}, ["redirect."]]
        end
      when Grit::Blob
        [200, {"Content-Type" => "text/html; charset=#{@file_encoding}"}, [wrap_html{ Orgmode::Parser.new(result.data.force_encoding(@file_encoding), 1).to_html }]]
      else
        [404, {"Content-Type" => "text/plane; charset=#{@file_encoding}"}, ["not found."]]
      end
    end

    def convert_file_path(str)
      path = str.
        gsub(%r!^#{@articles_url_prefix}!, '').
        gsub(%r!^/!, '')
      path.empty? ? '/' : URI.unescape(path).force_encoding(@file_encoding)
    end

    def wrap_html
      html = ""
      html << "<!DOCTYPE html><html><head></head><body>"
      html << yield if block_given?
      html << "</body></html>"
    end
  end
end
