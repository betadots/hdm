class KeysController < ApplicationController
  before_action :load_environments
  before_action :load_nodes

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :environments_path

  def index
    authorize! :show, Key
    @keys = Key.all_for(@node, environment: @environment)
    @keys.select! { |k| current_user.may_access?(k) }

    add_breadcrumb @environment, environment_nodes_path(@environment)
    add_breadcrumb @node, environment_node_keys_path(@environment, @node)
  end

  def show
    @keys = Key.all_for(@node, environment: @environment)
    @keys.select! { |k| current_user.may_access?(k) }
    @key = Key.new(environment: @environment, name: params[:id])
    authorize! :show, @key

    add_breadcrumb @environment, environment_nodes_path(@environment)
    add_breadcrumb @node, environment_node_keys_path(@environment, @node)
    add_breadcrumb params[:id], environment_node_key_path(@environment, @node, params[:id])
  end

  def update
    @key = Key.new(@node, params[:id])
    authorize! :update, @key
    @key.save_value(params[:hierarchy], params[:path], params[:value])

    redirect_to environment_node_key_path(@environment, @node, @key),
      notice: "Value was saved successfully"
  end

  def destroy
    @key = Key.new(@node, params[:id])
    authorize! :destroy, @key
    @key.remove_value(params[:hierarchy], params[:path])

    redirect_to environment_node_key_path(@environment, @node, @key),
      notice: "Value was removed successfully"
  end

  private

  def load_nodes
    @nodes = Node.all
    @nodes.select! { |n| current_user.may_access?(n) }
    @node = Node.find(params[:node_id])
    authorize! :show, @node
  end
end
