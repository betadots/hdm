require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  test "when no users exist an unauthenticated user can create an admin" do
    User.delete_all

    assert_difference "User.count" do
      post users_path, params: { user: FactoryBot.attributes_for(:user) }

      assert_redirected_to root_path
    end

    assert User.last.admin?
  end

  test "when users exists an unauthenticated user cannot create any users" do
    post users_path, params: { user: FactoryBot.attributes_for(:user) }

    assert_redirected_to login_path
  end

  test "admin can change a user's role" do
    admin = FactoryBot.create(:user, :admin)
    regular_user = FactoryBot.create(:user)

    sign_in_as admin

    patch user_path(regular_user), params: { user: { role: "admin" } }

    assert regular_user.reload.admin?
  end
end
