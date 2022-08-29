require "test_helper"

class NodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @environment = Environment.new(name: "development")
  end

  test "an admin cannot access the index page" do
    sign_in_as(users(:admin))

    get environment_nodes_path(@environment)

    assert_response(:forbidden)
  end

  test "a regular user can access the index page" do
    sign_in_as(users(:user))

    get environment_nodes_path(@environment)

    assert_response(:success)
  end
end
