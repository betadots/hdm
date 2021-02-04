class Puppet::OptionsController < ApplicationController
  load_and_authorize_resource :find_by => :slug

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :puppet_environments_path

  before_action :load_environment
  before_action :load_node

  def index
    @options = @node.options.order(:name)
  end

  def show
  end

  def new
    @option = @node.options.new
  end

  def edit
    @node.configurations.build
  end

  def create
    @option = @node.options.new(option_params)

    if @option.save
      redirect_to edit_puppet_environment_node_option_path(@environment, @node, @option), notice: 'Option was successfully created.'
    else
      render :new
    end
  end

  def update
    if @option.update(option_params)
      redirect_to edit_puppet_environment_node_option_path(@environment, @node, @option), notice: 'Option was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @option.destroy
    redirect_to puppet_environment_node_options_path(@environment, @node), notice: 'Option was successfully destroyed.'
  end

  private

  def load_environment
    @environment = Puppet::Environment.find_by(slug: params[:environment_id])
  end

  def load_node
    @node = @environment.nodes.find_by(slug: params[:node_id])

    add_breadcrumb @environment.name, puppet_environment_path(@environment)
    add_breadcrumb "Nodes", puppet_environment_nodes_path(@environment)
    add_breadcrumb @node.name, puppet_environment_node_path(@environment, @node)
    add_breadcrumb "Options", puppet_environment_node_options_path(@environment, @node)
  end

  def option_params
    params.require(:puppet_option).permit(:name, configurations_attributes: {})
  end
end
