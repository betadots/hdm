module Redirectable
  private

  def redirect_path
    if @configuration.configurable.present?
      find_redirect_for(@configuration)
    elsif @configuration.parent_configuration.present?
      find_redirect_for(@configuration.parent_configuration)
    end
  end

  def find_redirect_for(configuration)
    if configuration.configurable.is_a? Puppet::Environment
      [:edit, configuration.configurable]

    elsif configuration.configurable.is_a? Puppet::Node
      edit_puppet_environment_node_path(configuration.configurable.environment, configuration.configurable)

    elsif configuration.configurable.is_a? Puppet::Option
      node = configuration.configurable.node
      environment = node.environment
      edit_puppet_environment_node_option_path(environment, node, configuration.configurable)

    elsif configuration.parent_configuration
      find_redirect_for(configuration.parent_configuration)
    end
  end
end
