source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.6'
# Use Puma as the app server
gem 'puma', '~> 6.4'

# Asset handling
gem 'sprockets-rails'
gem 'importmap-rails'
gem 'dartsass-rails'
gem 'dartsass-sprockets'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'bootstrap', '~> 5.3.0'
gem 'bootstrap-icons-helper'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.20'

gem 'faker'
gem 'friendly_id', '~> 5.5.1'
gem 'puppet'
gem 'puppetdb-ruby', require: 'puppetdb'
gem 'hiera-eyaml'
gem 'net-ldap', require: "net/ldap"
gem 'breadcrumbs_on_rails'
gem 'cancancan'
gem 'ruby-saml'
gem 'diffy'

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

gem 'listen', '~> 3.2' # need for rake to precompile assets

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'rspec-openapi'
end

group :linter do
  gem 'rubocop', '~> 1.58.0'
  gem 'rubocop-rails', '~> 2.22.2'
  gem 'rubocop-rake', '~> 0.6.0'
  gem 'rubocop-capybara', '~> 2.19.0'
  gem 'rubocop-performance', '~> 1.19.0'
end

group :release do
  gem 'github_changelog_generator', '>= 1.16.1', :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'git'
gem 'gitable', require: "gitable/uri"

# dependencies & sec fixes
gem 'mini_racer' # minimal Google V8 JS engine for execjs
