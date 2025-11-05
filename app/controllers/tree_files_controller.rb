class TreeFilesController < ApplicationController
  before_action :ensure_rbac_disabled
  before_action :load_environments

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :environments_path

  def show
    add_breadcrumb @environment, environment_nodes_path(@environment)
    add_breadcrumb "Tree", environment_tree_path(@environment)
    add_breadcrumb params[:path_id]

    @layer = @environment.find_layer(name: params[:layer_id])
    @hierarchy = Hierarchy.find(layer: @layer, name: params[:hierarchy_id])
    @data_file = @hierarchy.file(path: params[:path_id])
  end
end
