class DecryptedValuesController < ApplicationController
  before_action :load_environments

  def create
    authorize! :decrypt, Value
    hierarchy = Hierarchy.find(@environment, params[:hierarchy_id])
    @decrypted_value = hierarchy.decrypt_value(params[:value].chomp)

    render plain: @decrypted_value
  end
end
