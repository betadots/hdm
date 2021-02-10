module Puppet
  module Configurable
    extend ActiveSupport::Concern

    included do
      extend FriendlyId
      friendly_id :name, use: :slugged

      has_many :configurations, as: :configurable, class_name: 'Puppet::Configuration', dependent: :destroy
      accepts_nested_attributes_for :configurations, allow_destroy: true
    end

    def to_s
      name
    end

    def display_configs
      @display_configs ||= configurations.select(&:persisted?).sort_by(&:id).each_with_object({}) do |configuration, hsh|
        hsh[configuration.name] = build_configuration_block(configuration)
      end
    end

    def create_config_for(hash, parent_config = nil)
      hash.each do |key, value|
        kind = get_kind_for_value(value)
        multiple_values = value.is_a?(Array)

        config = if parent_config
                   parent_config.child_configurations.where(name: key).first_or_create
                 else
                   configurations.where(name: key).first_or_create
                 end

        config.update multiple_values: multiple_values, kind: kind

        if value.is_a?(Hash)
          create_config_for(value, config)
        else
          [value].flatten.each { |val| config.values.find_or_create_by(value: val) }
        end
      end
    end

    private

    def get_kind_for_value(value)
      if %w(integer float string).any? { |kind| value.class.name.downcase == kind }
        value.class.name.downcase
      elsif value.is_a?(Array)
        get_kind_for_value(value.first)
      else
        'string'
      end
    end

    def build_configuration_block(configuration)
      if configuration.child_configurations.any?
        configuration.child_configurations.select(&:persisted?).sort_by(&:id).each_with_object({}) do |child_configuration, hsh|
          hsh[child_configuration.name] = build_configuration_block(child_configuration)
        end
      else
        values = configuration.values.select(&:persisted?)
        if configuration.multiple_values?
          values.map(&:value)
        else
          values.first&.value
        end
      end
    end
  end
end
