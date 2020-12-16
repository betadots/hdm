require 'test_helper'

class PageControllerTest < ActionDispatch::IntegrationTest
  test "system without an existing user shouldn't get index but new user form" do
    User.destroy_all
    FactoryBot.create(:role)
    get page_index_url
    assert_redirected_to new_user_path
  end

  test "system without an existing user nor role shouldn't get index but new user form" do
    User.destroy_all
    Role.destroy_all
    get page_index_url
    assert_redirected_to page_faulty_setup_path
  end

  test "system with existing user should get index" do
    FactoryBot.create(:user)
    get page_index_url
    assert_response :success
  end

  test "should get about_us" do
    User.destroy_all
    get page_about_us_url
    assert_response :success
  end
end
