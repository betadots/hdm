class NodesController < ApplicationController
  before_action :load_environments

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :environments_path

  def index
    @nodes = Node.all(environment: @environment)
    authorize! :index, Node

    add_breadcrumb @environment, environment_nodes_path(@environment)
  end
end
