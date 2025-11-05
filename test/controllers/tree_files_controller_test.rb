require "test_helper"

class TreeFilesControllerTest < ActionDispatch::IntegrationTest
  test "cannot access when RBAC is in use" do
    Group.create!(name: "test", restrict: "environment", rules: [/x/])
    sign_in_as(users(:user))

    get environment_tree_layer_hierarchy_path_tree_file_path(
      "development",
      "environment",
      "Eyaml hierarchy",
      "common.yaml"
    )

    assert_response(:forbidden)
  end
end
