require "test_helper"

class KeysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @environment = Environment.new("development")
    @node = Node.new("testhost")
  end

  test "an admin cannot access the index page" do
    sign_in_as(users(:admin))

    get environment_node_keys_path(@environment, @node)

    assert_response(:forbidden)
  end

  test "an admin cannot access the show page" do
    sign_in_as(users(:admin))

    get environment_node_key_path(@environment, @node, "hdm::integer")

    assert_response(:forbidden)
  end

  test "a regular user can access the index page" do
    sign_in_as(users(:user))

    get environment_node_keys_path(@environment, @node)

    assert_response(:success)
  end

  test "an regular user can access the show page" do
    sign_in_as(users(:user))

    get environment_node_key_path(@environment, @node, "hdm::integer")

    assert_response(:success)
  end
end
