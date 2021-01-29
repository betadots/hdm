class PuppetValuesController < ApplicationController
  load_and_authorize_resource :find_by => :slug

  before_action :load_puppet_environment
  before_action :load_puppet_node
  before_action :load_puppet_configuration

  def create
    @puppet_value = @puppet_configuration.puppet_values.new(puppet_value_params)

    if @puppet_value.save
      redirect_to [@puppet_environment, @puppet_node, :puppet_configurations], notice: 'Value was created'
    else
      load_puppet_configurations
      # render :index
      render template: 'puppet_configurations/index'
    end
  end

  private

  def load_puppet_environment
    @puppet_environment = PuppetEnvironment.find_by slug: params[:puppet_environment_id]
  end

  def load_puppet_node
    @puppet_node = @puppet_environment.puppet_nodes.find_by slug: params[:puppet_node_id]
  end

  def load_puppet_configuration
    @puppet_configuration = @puppet_node.puppet_configurations.find_by slug: params[:puppet_configuration_id]
  end

  def load_puppet_configurations
    @puppet_configurations =
      @puppet_node.puppet_configurations.includes(:puppet_values).where(parent_id: nil).order(:id)
  end

  def puppet_value_params
    params.require(:puppet_value).permit(:value)
  end
end
