class RolesController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb "Home", :root_path

  # GET /roles
  def index
    @roles = @roles.order(:name)
    add_breadcrumb "List roles", :roles_path
  end

  # GET /roles/1
  def show
    add_breadcrumb "List roles", :roles_path
    add_breadcrumb @role, :role_path
  end
end
