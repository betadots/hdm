class PuppetNode < ApplicationRecord
  belongs_to :puppet_environment

  def to_s
    fqdn
  end

  def hierachy_paths
    # Read the hiera configuration
    hiera_config = YAML.load_file(PUPPET_CONF_DIR + "/environments/#{self.puppet_environment.name}/hiera.yaml")

    if hiera_config["version"] == 5 # Only works with version 5.
      # Read the paths and replaces %{::...}
      result = []
      hiera_config["hierarchy"].each do |hierarchy|
        hierarchy["paths"].each do |hierachy_path|
          resolved_path = hierachy_path
          resolved_path = resolved_path.gsub("%{::fqdn}", self.fqdn)
          resolved_path = resolved_path.gsub("%{::zone}", self.zone)
          resolved_path = resolved_path.gsub("%{::role}", self.role)
          resolved_path = resolved_path.gsub("%{::env}", self.puppet_environment.name)
          result.push(resolved_path)
        end
      end

      return result
    end
  end
end
