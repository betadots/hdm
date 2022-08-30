class ValuesController < ApplicationController
  before_action :instantiate_models

  def update
    authorize! :update, Key

    @value.update(params[:value], node: @node)

    redirect_to environment_node_key_path(@environment, @node, @key),
                notice: "Value was saved successfully"
  end

  def destroy
    authorize! :destroy, Key

    @value.destroy(node: @node)

    redirect_to environment_node_key_path(@environment, @node, @key),
                status: :see_other,
                notice: "Value was removed successfully"
  end

  private

  def instantiate_models
    @environment = Environment.find(params[:environment_id])
    @node = Node.new(hostname: params[:node_id], environment: @environment)
    @hierarchy = Hierarchy.find(@environment, params[:hierarchy_id])
    @data_file = DataFile.new(hierarchy: @hierarchy, path: params[:data_file_id])
    @key = Key.new(environment: @environment, name: params[:key_id])
    @value = @data_file.value_for(key: @key)
  end
end
