class DecryptedValuesController < ApplicationController
  include EnvironmentAndNodeConcern

  def create
    authorize! :decrypt, Value
    hierarchy = Hierarchy.find(@node, params[:hierarchy])
    @decrypted_value = hierarchy.decrypt_value(params[:value].chomp)

    render plain: @decrypted_value
  end
end
