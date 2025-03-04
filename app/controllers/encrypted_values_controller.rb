class EncryptedValuesController < ApplicationController
  before_action :load_environments

  def create
    authorize! :encrypt, Value
    layer = @environment.find_layer(name: params[:layer_id])
    hierarchy = Hierarchy.find(layer: layer, name: params[:hierarchy_id])
    @encrypted_value = hierarchy.encrypt_value(params[:value])

    render plain: @encrypted_value
  end
end
