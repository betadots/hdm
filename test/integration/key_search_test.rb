require "test_helper"

class KeySearchTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user)
    sign_in_as(@user)
  end

  test "user without groups can find key" do
    get environment_key_files_path(environment_id: "development", key_id: "hdm::integer")

    assert_response :success
    assert_select "p.lead", /Found\s+key\s+hdm::integer\s+in\s+2\s+files./
  end

  test "user with group that forbids access cannot find key" do
    group = FactoryBot.create(:group, :key, rules: [/psick/])
    group.users << @user

    get environment_key_files_path(environment_id: "development", key_id: "hdm::integer")

    assert_response :success
    assert_select "p.lead", /Could not find key\s+hdm::integer\s+in any files, or you are not allowed to access this key\./
  end
end
