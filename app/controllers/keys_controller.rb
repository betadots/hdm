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
    @key = Key.new(name: params[:id], hiera_data: @environment.hiera_data)
    authorize! :show, @key

    add_breadcrumb @environment, environment_nodes_path(@environment)
    add_breadcrumb @node, environment_node_keys_path(@environment, @node)
    add_breadcrumb params[:id], environment_node_key_path(@environment, @node, params[:id])
  end
end
