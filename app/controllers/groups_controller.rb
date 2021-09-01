class GroupsController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Groups", :groups_path
    @groups = @groups.order(:name)
  end

  def show
    add_breadcrumb "Groups", :groups_path
    add_breadcrumb @group.name, group_path(@group)
  end

  def new
    add_breadcrumb "Groups", :groups_path
    add_breadcrumb "New Group", new_group_path
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: "Group was created successfully."
    else
      render action: "new"
    end
  end

  def edit
    add_breadcrumb "Groups", :groups_path
    add_breadcrumb @group.name, group_path(@group)
    add_breadcrumb "Edit", edit_group_path(@group)
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: "Group was updated successfully."
    else
      render action: "edit"
    end
  end

  def destroy
    @group.destroy

    redirect_to groups_path, notice: "Group was deleted successfully"
  end

  private

  def group_params
    permitted_params = params
      .require(:group)
      .permit(:name, :restrict, rules: [])
    permitted_params[:rules] ||= []
    permitted_params
  end
end
