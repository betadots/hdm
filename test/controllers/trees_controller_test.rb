require "test_helper"

class TreesControllerTest < ActionDispatch::IntegrationTest
  test "cannot access when RBAC is in use" do
    Group.create!(name: "test", restrict: "environment", rules: [/x/])
    sign_in_as(users(:user))

    get environment_tree_path("development")

    assert_response(:forbidden)
  end
end
