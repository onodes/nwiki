# -*- coding: utf-8 -*-
require "nwiki"

require "rspec"
require "rack/test"

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

module Nwiki
  CONFIG = {
      data_file_directory: './spec/data',
      feeds_url_prefix: '/feeds',
      articles_url_prefix: '/articles',
      site_title: "ヽ（´・肉・｀）ノログ",
      site_description: "How do we fighting without fighting?",
      site_link: "http://niku.name",
      site_author: "niku",
  }
end
