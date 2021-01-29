class PuppetEnvironment < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :puppet_nodes

  def to_s
    name
  end

  def common_config
    file_name = PUPPET_CONF_DIR + "/environments/#{self.name}/data/common.yaml"

    if File.exist?(file_name)
      YAML.load_file(file_name)
    else
      nil
    end
  end

end
