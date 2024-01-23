require 'test_helper'

class PageControllerTest < ActionDispatch::IntegrationTest
  test "system without an existing user shouldn't get index but initial setup page" do
    User.destroy_all
    get root_url
    assert_redirected_to initial_setup_path
  end

  test "system with existing user should get index" do
    FactoryBot.create(:user)
    get root_url
    assert_response :success
  end

  test "system with authentication disabled should get index" do
    Rails.configuration.hdm["authentication_disabled"] = true
    get root_url
    assert_response :success
    Rails.configuration.hdm["authentication_disabled"] = nil
  end
end
