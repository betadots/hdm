require 'listen'

def rebase_puppet_nodes(config_file)
  node_config = YAML.load_file(config_file)
  puppet_environment = PuppetEnvironment.find_or_create_by(name: node_config['env'])

  puppet_node = PuppetNode.find_or_create_by(
                                fqdn: node_config['fqdn'], 
                                role: node_config['role'],
                                puppet_environment: puppet_environment,
                                zone: node_config['zone'],
                                organization: node_config['organization'],
                                os_family: node_config['os']['family'],
                                os_lsbdistcodename: node_config['os']['lsbdistcodename'],
                                config_file_name: File.basename(config_file, '')
  )
end

def delete_node(config_file)
  PuppetNode.where(config_file_name: File.basename(config_file, '')).destroy_all
end

# Feed all existing files into the DB
#
ActiveRecord::Base.connection.tables
if ActiveRecord::Base.connection.table_exists?('puppet_environments') && 
   ActiveRecord::Base.connection.table_exists?('puppet_nodes')
  Dir.glob("#{PUPPET_CONF_DIR}/nodes/*_facts.yaml").each do |node_config_file|
    rebase_puppet_nodes(node_config_file)
  end
end

# Listen if any file changes and update the DB
#
listener = Listen.to(PUPPET_CONF_DIR) do |modified, added, removed|
  if modified.any?
    Rails.logger.info("Puppet configuration modified: #{modified}")
  end
  if added.any?
    Rails.logger.info("Puppet configuration added: #{added}")
    added.each do |config_file|
      rebase_puppet_nodes(config_file)
    end
  end
  if removed.any?
    Rails.logger.info("Puppet configuration removed: #{removed}")
    removed.each do |config_file|
      delete_node(config_file)
    end
  end
end
listener.start

