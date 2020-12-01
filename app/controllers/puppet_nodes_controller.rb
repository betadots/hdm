class PuppetNodesController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb "Home", :root_path

  # GET /puppet_nodes
  def index
    add_breadcrumb "Nodes", :puppet_nodes_path
    @puppet_nodes = @puppet_nodes.order(:fqdn)
  end

  # GET /puppet_nodes/1
  def show
    add_breadcrumb "Nodes", :puppet_nodes_path
    add_breadcrumb @puppet_node.fqdn, puppet_node_path(@puppet_node)
  end

  # GET /puppet_nodes/new
  def new
    @puppet_node = PuppetNode.new
  end

  # GET /puppet_nodes/1/edit
  def edit
  end

  # POST /puppet_nodes
  def create
    @puppet_node = PuppetNode.new(puppet_node_params)

    if @puppet_node.save
      redirect_to @puppet_node, notice: 'Puppet node was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /puppet_nodes/1
  def update
    if @puppet_node.update(puppet_node_params)
      redirect_to @puppet_node, notice: 'Puppet node was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /puppet_nodes/1
  def destroy
    @puppet_node.destroy
    redirect_to puppet_nodes_url, notice: 'Puppet node was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def puppet_node_params
      params.require(:puppet_node).permit(:fqdn, :role, :puppet_environment_id, :zone, :os_family, :os_lsbdistcodename, :organization)
    end
end
