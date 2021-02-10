require 'listen'

def rebase_puppet_nodes(config_file)
  node_config = YAML.load_file(config_file)
  environment = Puppet::Environment.find_or_create_by(name: node_config['env'])

  node_name = File.basename(config_file, '')
  node = Puppet::Node.where(environment: environment, name: node_name).first_or_create
  node.create_config_for(node_config)


  node.hierachy_paths.each do |hierachy_path|
    file_name = PUPPET_CONF_DIR + "/data/#{hierachy_path}"
    option = node.options.where(name: hierachy_path).first_or_create
    next unless File.exist?(file_name)

    option_config = YAML.load_file(file_name)
    option.create_config_for(option_config)
  end
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
