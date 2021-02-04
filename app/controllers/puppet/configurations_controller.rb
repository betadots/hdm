class Puppet::ConfigurationsController < ApplicationController
  include Redirectable

  load_and_authorize_resource :find_by => :id

  helper_method :redirect_path

  def edit
  end

  def update
    if @configuration.update(configuration_params)
      redirect_to redirect_path, notice: 'Configuration was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @configuration.destroy
    redirect_to redirect_path, notice: 'Configuration was successfully destroyed'
  end

  private

  def configuration_params
    params.require(:puppet_configuration).permit(:name, child_configurations_attributes: {})
  end
end
