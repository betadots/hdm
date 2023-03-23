class NodesController < ApplicationController
  before_action :load_environments

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :environments_path

  def index
    authorize! :index, Node
    @nodes = Node.all
    @nodes.select! { |n| current_user.may_access?(n) }

    add_breadcrumb @environment, environment_nodes_path(@environment)
  end
end
