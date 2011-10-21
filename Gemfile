source "http://rubygems.org"

# Specify your gem's dependencies in nwiki.gemspec
gemspec

gem "rake"
gem "rack"
gem "org-ruby", :git => "git://github.com/niku/org-ruby.git", :branch => "fix_ruby19"
gem "grit", :git => "git://github.com/niku/grit.git", :branch => "fix_multibyte"
gem "rubypants"
gem 'rack-google-analytics', :require => 'rack/google-analytics'

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
