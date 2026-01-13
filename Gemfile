source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: '.ruby-version'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.1.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 2.9'
# Use Puma as the app server
gem 'puma', '~> 7.1'

# Asset handling
gem 'bootstrap', '~> 5.3.8'
gem 'bootstrap-icons-helper'
gem 'dartsass-rails'
gem 'dartsass-sprockets'
gem 'importmap-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.21'

gem 'breadcrumbs_on_rails'
gem 'cancancan'
gem 'deep_merge', require: "deep_merge/core"
gem 'diffy'
gem 'faker'
gem 'friendly_id', '~> 5.6.0'
gem 'hiera-eyaml'
gem 'net-ldap', require: "net/ldap"
gem 'openvox', '~> 8.24'
gem 'net-http'
gem 'puppetdb-ruby', require: 'puppetdb'
gem 'syslog', '~> 0.3.0' # was ruby default, is not anymore in 3.4.x, is required by puppet
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
  gem 'minitest', '< 7'
end

group :linter do
  gem 'rubocop', '~> 1.82.1'
  gem 'rubocop-capybara', '~> 2.22.1'
  gem 'rubocop-performance', '~> 1.26.1'
  gem 'rubocop-rails', '~> 2.34.3'
  gem 'rubocop-rake', '~> 0.7.1'
  gem 'rubocop-factory_bot', '~> 2.28.0'
end

group :release do
  gem 'openssl', '~> 4.0'
  gem 'github_changelog_generator', '>= 1.16.1', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'git'
gem 'gitable', require: "gitable/uri"

# see https://github.com/rubyjs/mini_racer/issues/344
gem 'mini_racer', '~> 0.16.0'    # minimal Google V8 JS engine for execjs
# see https://github.com/rubyjs/libv8-node/issues/60
gem 'libv8-node', '~> 18.19.0.0' # V8 JS engine

# Alpine specific
#
# There is an issue with rails -> sass-embedded -> libv8-node -> protobuf
#
# We have to force bundler to compile protobuf on the current platform
# and do not download precompile binary-gems, otherwise the usage of relying gems will segfault
gem 'google-protobuf', force_ruby_platform: true
