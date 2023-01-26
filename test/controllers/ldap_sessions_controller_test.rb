require "test_helper"

class LdapSessionsControllerTest < ActionDispatch::IntegrationTest
  test "#new displays the login page" do
    get new_ldap_session_path

    assert_response :success
  end

  test "#create with correct credentials redirects to root path" do
    user = FactoryBot.create(:user)
    user_entry = Minitest::Mock.new
    stubbed_ldap(authenticate_result: [user_entry]) do
      post ldap_session_path, params: { email: user.email, password: "secret" }

      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  test "#create with incorrect credentials redisplays login page" do
    stubbed_ldap(authenticate_result: nil) do
      post ldap_session_path,
           params: { email: "noboby@example.com", password: "secret" }

      assert_response :unprocessable_entity
    end
  end

  private

  def stubbed_ldap(authenticate_result:, &block)
    ldap = Minitest::Mock.new
    ldap.expect(:authenticate, authenticate_result, [String, String])
    Ldap.stub(:new, ldap, &block)
  end
end
