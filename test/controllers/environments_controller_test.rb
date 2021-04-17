require "test_helper"

class EnvironmentsControllerTest < ActionDispatch::IntegrationTest
  test "an admin cannot access the index page" do
    sign_in_as(users(:admin))

    get environments_path

    assert_response(:forbidden)
  end

  test "a regular user can access the index page" do
    sign_in_as(users(:user))

    get environments_path

    assert_response(:success)
  end
end
