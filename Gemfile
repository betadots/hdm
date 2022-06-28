source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.6'

# Asset handling
gem 'sprockets-rails'
gem 'importmap-rails'
gem 'dartsass-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'bootstrap', '~> 4.6.0'
gem 'bootstrap-icons-helper'
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'faker'
gem 'friendly_id', '~> 5.4.0'
gem 'puppet'
gem 'puppetdb-ruby', require: 'puppetdb'
gem 'hiera-eyaml'
gem 'net-ldap', require: "net/ldap"

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'breadcrumbs_on_rails'
gem 'cancancan'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'simplecov', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :linter do
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Professional version only gems
gem 'git'
gem 'gitable', require: "gitable/uri"

# dependencies & sec fixes
# gem "nokogiri", ">= 1.13.2" # needs ruby >= 2.6.0
gem 'mini_racer' # minimal Google V8 JS engine for execjs
