require './lib/nwiki'

DATA_PATH = './spec/data'

map '/feeds' do
  run Nwiki::Feeds.new(DATA_PATH)
end

map '/articles' do
  run Nwiki::Articles.new(DATA_PATH)
end
