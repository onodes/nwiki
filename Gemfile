source "http://rubygems.org"

# Specify your gem's dependencies in nwiki.gemspec
gemspec

gem "rake"
gem "rack"
gem "org-ruby"

group :development do
  gem "rspec"
  gem "rack-test"

  # for guard
  gem "guard"
  gem "guard-rspec"
  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent', :require => false
    gem 'growl', :require => false
  end
end
