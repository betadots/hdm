class EncryptedValuesController < ApplicationController
  include EnvironmentAndNodeConcern

  def create
    authorize! :encrypt, Value
    hierarchy = Hierarchy.find(@environment, @node, params[:hierarchy])
    @encrypted_value = hierarchy.encrypt_value(params[:value])

    render plain: @encrypted_value
  end
end
