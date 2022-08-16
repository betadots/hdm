require "test_helper"

class RequiredAuthenticationTest < ActionDispatch::IntegrationTest
  class AuthenticationEnabledTest < ActionDispatch::IntegrationTest
    test "authentication requirements for environments" do
      authentication_required_for :get, environments_path
    end

    test "authentication requiremens for nodes" do
      authentication_required_for :get, environment_nodes_path("development")
    end

    test "authentication requirements for keys" do
      authentication_required_for :get,
        environment_node_keys_path("development", "testhost")
      authentication_required_for :get,
        environment_node_key_path("development", "testhost", "hdm::integer")
      authentication_required_for :patch,
        environment_node_key_path("development", "testhost", "hdm::integer")
      authentication_required_for :delete,
        environment_node_key_path("development", "testhost", "hdm::integer")
    end

    test "authentication requirements for decrypted values" do
      authentication_required_for :post,
        environment_node_decrypted_values_path("development", "testhost")
    end

    test "authentication requirements for encrypted values" do
      authentication_required_for :post,
        environment_node_encrypted_values_path("development", "testhost")
    end

    test "authentication requirements for users" do
      user = FactoryBot.create(:user, admin: true)

      authentication_required_for :get, users_path
      authentication_required_for :get, user_path(user)
      authentication_required_for :get, new_user_path
      authentication_required_for :post, users_path
      authentication_required_for :get, edit_user_path(user)
      authentication_required_for :patch, user_path(user)
      authentication_required_for :delete, user_path(user)
    end

    private

    def authentication_required_for(method, path)
      send(method, path)
      assert_redirected_to login_path
    end
  end

  class AuthenticationDisabledTest < ActionDispatch::IntegrationTest
    setup do
      Rails.configuration.hdm["authentication_disabled"] = true
    end

    teardown do
      Rails.configuration.hdm["authentication_disabled"] = nil
    end

    test "authentication requirements for environments" do
      no_authentication_required_for :get, environments_path
    end

    test "authentication requiremens for nodes" do
      no_authentication_required_for :get, environment_nodes_path("development")
    end

    test "authentication requirements for keys" do
      no_authentication_required_for :get,
        environment_node_keys_path("development", "testhost")
      no_authentication_required_for :get,
        environment_node_key_path("development", "testhost", "hdm::integer")
    end

    private

    def no_authentication_required_for(method, path)
      send(method, path)
      assert_response :success
    end
  end
end
