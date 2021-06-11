class DecryptedValuesController < ApplicationController
  before_action :load_environment
  before_action :load_node

  def show
    authorize! :show, Key
    hierarchy = Hierarchy.find(@environment, @node, params[:hierarchy])
    key = Key.new(@environment, @node, params[:id])
    @value = hierarchy.values_for(key).find { |v| v.path == params[:path] }

    render plain: @value.value(decrypt: true)
  end

  private

  def load_environment
    @environment = Environment.find(params[:environment_id])
  end

  def load_node
    @node = Node.find(params[:node_id])
  end
end
