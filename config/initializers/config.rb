contract = Class.new(Dry::Validation::Contract)
contract.params do
  required(:config_dir).filled(:string)


  optional(:puppet_db).schema do
    optional(:enabled).value(:bool)
    optional(:server).value(:string)
  end
end

contract.rule(:config_dir) do
  unless File.exist?("#{value}")
    key.failure("Config dir #{value} does not exist")
  end
end

contract.rule(puppet_db: :server) do
  if !values[:puppet_db] || !values[:puppet_db][:server]
    key.failure("You must set a value for PuppetDB Server")
  end
end

Config.setup do |config|
  # Name of the constant exposing loaded settings
  config.const_name = 'Settings'

  # Ability to remove elements of the array set in earlier loaded settings file. For example value: '--'.
  #
  # config.knockout_prefix = nil

  # Overwrite an existing value when merging a `nil` value.
  # When set to `false`, the existing value is retained after merge.
  #
  # config.merge_nil_values = true

  # Overwrite arrays found in previously loaded settings file. When set to `false`, arrays will be merged.
  #
  # config.overwrite_arrays = true

  # Load environment variables from the `ENV` object and override any settings defined in files.
  #
  config.use_env = true

  # Define ENV variable prefix deciding which variables to load into config.
  #
  config.env_prefix = 'HDM'

  # What string to use as level separator for settings loaded from ENV variables. Default value of '.' works well
  # with Heroku, but you might want to change it for example for '__' to easy override settings from command line, where
  # using dots in variable names might not be allowed (eg. Bash).
  #
  # config.env_separator = '.'
  config.env_separator = '__'

  # Ability to process variables names:
  #   * nil  - no change
  #   * :downcase - convert to lower case
  #
  config.env_converter = :downcase

  # Parse numeric values as integers instead of strings.
  #
  config.env_parse_values = true

  # Validate presence and type of specific config values. Check https://github.com/dry-rb/dry-validation for details.
  #
  # config.schema do
  #   required(:name).filled
  #   required(:age).maybe(:int?)
  #   required(:email).filled(format?: EMAIL_REGEX)
  # end

  config.validation_contract = contract.new
end
