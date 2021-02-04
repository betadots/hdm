class Puppet::ValuesController < ApplicationController
  load_and_authorize_resource :find_by => :id

  include Redirectable

  before_action :load_configuration

  def create
    @value = @configuration.values.new(value_params)

    if @value.save
      redirect_to redirect_path, notice: 'Value was successfully created'
    else
      redirect_to redirect_path, error: 'Value was not created'
    end
  end

  def destroy
    @value.destroy
    redirect_to redirect_path, notice: 'Value was successfully destroyed'
  end

  private

  def load_configuration
    @configuration = Puppet::Configuration.find(params[:configuration_id])
  end

  def value_params
    params.require(:puppet_value).permit(:value)
  end
end
