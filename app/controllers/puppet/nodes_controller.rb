class Puppet::NodesController < ApplicationController
  load_and_authorize_resource :find_by => :slug

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :puppet_environments_path

  before_action :load_environment

  def index
    @nodes = @environment.nodes.order(:name)
  end

  def show
  end

  def new
    @node = @environment.nodes.new
  end

  def edit
    @node.configurations.build
  end

  def create
    @node = @environment.nodes.new(node_params)

    if @node.save
      redirect_to edit_puppet_environment_node_path(@environment, @node), notice: 'Node was successfully created.'
    else
      render :new
    end
  end

  def update
    if @node.update(node_params)
      redirect_to edit_puppet_environment_node_path(@environment, @node), notice: 'Node was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @environment.destroy
    redirect_to puppet_environment_nodes_path, notice: 'Node was successfully destroyed.'
  end

  private

  def load_environment
    @environment = Puppet::Environment.find_by(slug: params[:environment_id])

    add_breadcrumb @environment.name, puppet_environment_path(@environment)
    add_breadcrumb "Nodes", puppet_environments_path
  end

  def node_params
    params.require(:puppet_node).permit(:name, configurations_attributes: {})
  end
end
