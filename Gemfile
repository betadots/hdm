source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: '.ruby-version'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.2.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 2.1'
# Use Puma as the app server
gem 'puma', '~> 6.4'

# Asset handling
gem 'bootstrap', '~> 5.3.3'
gem 'bootstrap-icons-helper'
gem 'dartsass-rails'
gem 'dartsass-sprockets'
gem 'importmap-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.20'

gem 'breadcrumbs_on_rails'
gem 'cancancan'
gem 'deep_merge', require: "deep_merge/core"
gem 'diffy'
gem 'faker'
gem 'friendly_id', '~> 5.5.1'
gem 'hiera-eyaml'
gem 'net-ldap', require: "net/ldap"
gem 'ostruct', '~> 0.6.1' # was ruby default, is not anymore in 3.5.x, is required by net-ldap
gem 'puppet'
gem 'puppetdb-ruby', require: 'puppetdb'
gem 'syslog', '~> 0.2.0' # was ruby default, is not anymore in 3.4.x, is required by puppet
gem 'ruby-saml'

# To use retry middleware with Faraday v2.0+
gem 'faraday-retry'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'simplecov', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

gem 'listen', '~> 3.9' # need for rake to precompile assets

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'rspec-openapi'
  gem 'selenium-webdriver'
end

group :linter do
  gem 'rubocop', '~> 1.72.1'
  gem 'rubocop-capybara', '~> 2.21.0'
  gem 'rubocop-performance', '~> 1.24.0'
  gem 'rubocop-rails', '~> 2.30.1'
  gem 'rubocop-rake', '~> 0.7.1'
end

group :release do
  gem 'github_changelog_generator', '>= 1.16.1', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'git'
gem 'gitable', require: "gitable/uri"

# dependencies & sec fixes
gem 'mini_racer', '~> 0.16.0'    # minimal Google V8 JS engine for execjs
gem 'libv8-node', '~> 18.19.0.0' # V8 JS engine

# Alpine specific
#
# There is an issue with rails -> sass-embedded -> libv8-node -> protobuf
#
# We have to force bundler to compile protobuf on the current platform
# and do not download precompile binary-gems, otherwise the usage of relying gems will segfault
gem 'google-protobuf', force_ruby_platform: true
