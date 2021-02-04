class Puppet::Environment < ApplicationRecord
  include Puppet::Configurable

  has_many :nodes, class_name: 'Puppet::Node', foreign_key: :puppet_environment_id

  def common_config
    file_name = PUPPET_CONF_DIR + "/environments/#{self.name}/data/common.yaml"

    if File.exist?(file_name)
      YAML.load_file(file_name)
    else
      nil
    end
  end
end
