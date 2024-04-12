class ValuesController < ApplicationController
  before_action :instantiate_models

  def update
    authorize! :update, Key

    @value.update(params[:value])

    redirect_to environment_node_key_path(@environment, @node, @key),
                notice: "Value was saved successfully"
  end

  def destroy
    authorize! :destroy, Key

    @value.destroy

    redirect_to environment_node_key_path(@environment, @node, @key),
                status: :see_other,
                notice: "Value was removed successfully"
  end

  private

  def instantiate_models
    @environment = Environment.find(params[:environment_id])
    @node = Node.new(hostname: params[:node_id], environment: @environment)
    @layer = @environment.find_layer(name: params[:layer_id])
    @hierarchy = Hierarchy.find(layer: @layer, name: params[:hierarchy_id])
    @data_file = @hierarchy.file(path: params[:data_file_id], node: @node)
    @key = Key.new(name: params[:key_id])
    @value = @data_file.value_for(key: @key)
  end
end
