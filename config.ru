# -*- coding: utf-8 -*-
require './lib/nwiki'

CONF = {
  data_file_directory: './spec/data',
  feeds_url_prefix: '/feeds',
  articles_url_prefix: '/articles',
  site_title: "ヽ（´・肉・｀）ノログ",
  site_description: "How do we fighting without fighting?",
  site_link: "http://niku.name",
  site_author: "niku",
}

map CONF[:feeds_url_prefix] do
  run Nwiki::Feeds.new(CONF)
end

map CONF[:articles_url_prefix] do
  run Nwiki::Articles.new(CONF)
end
