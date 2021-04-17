require 'test_helper'

class PageControllerTest < ActionDispatch::IntegrationTest
  test "system without an existing user shouldn't get index but new user form" do
    User.destroy_all
    FactoryBot.create(:role)
    get page_index_url
    assert_redirected_to new_user_path
  end

  test "system without an existing user nor role shouldn't get index but display an error" do
    User.destroy_all
    Role.destroy_all
    get page_index_url
    assert_response :internal_server_error
    assert_select "h5", "HDM Error"
  end

  test "system with existing user should get index" do
    FactoryBot.create(:user)
    get page_index_url
    assert_response :success
  end
end
