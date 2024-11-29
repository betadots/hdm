require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hdm
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.generators.assets = nil
    config.generators.helper = nil

    # Alow the use of sqlite in production mode without warning.
    # We only use sqlite for user management.
    config.active_record.sqlite3_production_warning = false

    # Allow serialization of Regexp as Group access rules
    # are defined using regular expressions.
    config.active_record.yaml_column_permitted_classes = [Regexp]

    config.hdm = config_for(:hdm)
  end
end
