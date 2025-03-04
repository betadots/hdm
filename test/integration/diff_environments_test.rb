require "test_helper"

class DiffEnvironmentsTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user)
    sign_in_as(@user)
  end

  test "showing node in different environment displays diff" do
    get environment_node_key_path("eyaml", "1m73otky.betadots.training", "1j1wdwae")

    assert_response :success
    assert_select "button#tab-diff-data_file_common-yaml"
  end
end
