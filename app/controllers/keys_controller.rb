class KeysController < ApplicationController
  before_action :load_environments
  before_action :load_nodes

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :environments_path

  def index
    authorize! :show, Key
    @keys = Key.all(@environment, @node)

    add_breadcrumb @environment, environment_nodes_path(@environment)
    add_breadcrumb @node, environment_node_keys_path(@environment, @node)
  end

  def show
    authorize! :show, Key
    @keys = Key.all(@environment, @node)
    @key = Key.new(@environment, @node, params[:id])

    add_breadcrumb @environment, environment_nodes_path(@environment)
    add_breadcrumb @node, environment_node_keys_path(@environment, @node)
    add_breadcrumb params[:id], environment_node_key_path(@environment, @node, params[:id])
  end

  def update
    authorize! :update, Key

    @key = Key.new(@environment, @node, params[:id])
    @key.save_value(params[:hierarchy], params[:path], params[:value])

    redirect_to environment_node_key_path(@environment, @node, @key),
      notice: "Value was saved successfully"
  end

  def destroy
    authorize! :destroy, Key

    @key = Key.new(@environment, @node, params[:id])
    @key.remove_value(params[:hierarchy], params[:path])

    redirect_to environment_node_key_path(@environment, @node, @key),
      notice: "Value was removed successfully"
  end

  private

  def load_nodes
    @nodes = Node.all(environment: @environment)
    @node = Node.find(params[:node_id])
  end
end
