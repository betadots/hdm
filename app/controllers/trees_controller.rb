class TreesController < ApplicationController
  before_action :ensure_rbac_disabled
  before_action :load_environments

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :environments_path

  def show
    add_breadcrumb @environment, environment_nodes_path(@environment)
    add_breadcrumb "Tree"
  end
end
