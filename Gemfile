source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.7'
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
gem 'diffy'
gem 'faker'
gem 'friendly_id', '~> 5.5.1'
gem 'hiera-eyaml'
gem 'net-ldap', require: "net/ldap"
gem 'puppet'
gem 'puppetdb-ruby', require: 'puppetdb'
gem 'ruby-saml'
gem 'deep_merge', require: "deep_merge/core"

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
  gem 'rubocop', '~> 1.64.1'
  gem 'rubocop-capybara', '~> 2.20.0'
  gem 'rubocop-performance', '~> 1.21.0'
  gem 'rubocop-rails', '~> 2.25.0'
  gem 'rubocop-rake', '~> 0.6.0'
end

group :release do
  gem 'github_changelog_generator', '>= 1.16.1', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'git'
gem 'gitable', require: "gitable/uri"

# dependencies & sec fixes
gem 'mini_racer' # minimal Google V8 JS engine for execjs
