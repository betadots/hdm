class GroupMembershipsController < ApplicationController
  load_and_authorize_resource :group
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Groups", :groups_path

  def edit
    add_breadcrumb @group.name, group_path(@group)
    add_breadcrumb "Edit Memberships", edit_group_group_memberships_path(@group)
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: "Group memberships were updated successfully."
    else
      render action: "edit"
    end
  end

  private

  def group_params
    params.require(:group).permit(user_ids: [])
  end
end
