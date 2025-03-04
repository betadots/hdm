class DecryptedValuesController < ApplicationController
  before_action :load_environments

  def create
    authorize! :decrypt, Value
    layer = @environment.find_layer(name: params[:layer_id])
    hierarchy = Hierarchy.find(layer: layer, name: params[:hierarchy_id])
    @decrypted_value = hierarchy.decrypt_value(params[:value].chomp)

    render plain: @decrypted_value
  end
end
