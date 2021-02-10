class Puppet::Node < ApplicationRecord
  include Puppet::Configurable

  belongs_to :environment, foreign_key: :puppet_environment_id
  has_many :options, foreign_key: :puppet_node_id, dependent: :destroy

  def hiera_config
    # Read the hiera configuration
    @hiera_config ||= YAML.load_file(PUPPET_CONF_DIR + "/environments/#{self.environment.name}/hiera.yaml")
  end

  def hierachy_paths
    if hiera_config["version"] == 5 # Only works with version 5.
      # Read the paths and replaces %{::...}
      result = []
      hiera_config["hierarchy"].each do |hierarchy|
        hierarchy["paths"].each do |hierachy_path|
          resolved_path = hierachy_path
          resolved_path = resolved_path.gsub("%{::fqdn}", display_configs['fqdn'])
          resolved_path = resolved_path.gsub("%{::zone}", display_configs['zone'])
          resolved_path = resolved_path.gsub("%{::role}", display_configs['role'])
          resolved_path = resolved_path.gsub("%{::env}", display_configs['env'])
          result.push(resolved_path)
        end
      end

      return result
    end
  end

  def node_config
    if hiera_config["version"] == 5 # Only works with version 5.
      # Read the paths and replaces %{::...}
      result = []
      hiera_config["hierarchy"].each do |hierarchy|
        hierarchy["paths"].each do |hierachy_path|
          if hierachy_path.include? '::fqdn'
            resolved_path = hierachy_path
            resolved_path = resolved_path.gsub("%{::fqdn}", self.fqdn)
            result.push(resolved_path)
          end
        end
      end

      unless result.empty?
        file_name = PUPPET_CONF_DIR + "/data/#{result.first}"
        if File.exist?(file_name)
          config = YAML.load_file(file_name)
        else
          config = nil
        end

        return config
      end
    end
  end

  def complete_config
    complete_config = nil

    hierachy_paths.each do |hierachy_path|
      file_name = PUPPET_CONF_DIR + "/data/#{hierachy_path}"
      if File.exist?(file_name)
        config = YAML.load_file(file_name)
        if complete_config.nil?
          complete_config = config
        else
          complete_config = complete_config.deep_merge!(config)
        end
      end
    end

    complete_config
  end
end
