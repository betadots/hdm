class PuppetConfigurationsController < ApplicationController
  load_and_authorize_resource :find_by => :slug

  before_action :load_puppet_environment
  before_action :load_puppet_node
  before_action :load_puppet_configurations, only: [:index]

  add_breadcrumb "Home", :root_path

  def index
    @puppet_configurations = @puppet_node.puppet_configurations.where(parent_id: nil).order(:id)
    @puppet_configuration = PuppetConfiguration.new
  end

  def create
    @puppet_configuration = @puppet_node.puppet_configurations.new(puppet_configuration_params)

    if @puppet_configuration.save
      redirect_to [@puppet_environment, @puppet_node, :puppet_configurations], notice: 'Configuration was created'
    else
      load_puppet_configurations
      render :index
    end
  end

  private

  def load_puppet_environment
    @puppet_environment = PuppetEnvironment.find_by slug: params[:puppet_environment_id]
  end

  def load_puppet_node
    @puppet_node = @puppet_environment.puppet_nodes.find_by slug: params[:puppet_node_id]
  end

  def load_puppet_configurations
    @puppet_configurations =
      @puppet_node.puppet_configurations.includes(:puppet_values).where(parent_id: nil).order(:id)
  end

  def puppet_configuration_params
    params.require(:puppet_configuration).permit(:name, :kind, :multiple_values)
  end
end
