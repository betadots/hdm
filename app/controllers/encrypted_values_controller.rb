class EncryptedValuesController < ApplicationController
  before_action :load_environments

  def create
    authorize! :encrypt, Value
    hierarchy = Hierarchy.find(@environment, params[:hierarchy_id])
    @encrypted_value = hierarchy.encrypt_value(params[:value])

    render plain: @encrypted_value
  end
end
