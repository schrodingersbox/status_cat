source "http://rubygems.org"

# Declare your gem's dependencies in status_cat.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

group :development, :test do
  gem 'rspec-rails', '2.11.0'
  gem 'simplecov', '0.6.4', :require => false
  gem 'spec-cat', :git => 'https://github.com/schrodingersbox/spec-cat.git'
  gem 'webrat', '0.7.3'
end
