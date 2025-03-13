require "test_helper"

class EncryptedValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @allow_encryption = Rails.configuration.hdm["allow_encryption"]
    Rails.configuration.hdm["allow_encryption"] = true

    sign_in_as(users(:user))
  end

  teardown do
    Rails.configuration.hdm["allow_encryption"] = @allow_encryption
  end

  test "POST :create" do
    post environment_layer_hierarchy_encrypted_values_path("eyaml", "environment", "Global data"), params: { value: "test" }

    assert_response :success
  end
end
