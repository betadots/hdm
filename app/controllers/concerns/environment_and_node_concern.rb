module EnvironmentAndNodeConcern
  extend ActiveSupport::Concern

  included do
    before_action :load_environment
    before_action :load_node
  end

  private

  def load_environment
    @environment = Environment.find(params[:environment_id])
  end

  def load_node
    @node = Node.new(hostname: params[:node_id], environment: @environment)
  end
end
