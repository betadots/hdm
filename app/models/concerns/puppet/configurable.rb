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
      configurations.select(&:persisted?).sort_by(&:id).each_with_object({}) do |configuration, hsh|
        hsh[configuration.name] = build_configuration_block(configuration)
      end
    end

    private

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
