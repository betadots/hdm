require "test_helper"

class SamlSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Rails.configuration.hdm[:saml] = SAML_TEST_CONFIG.dup
  end

  teardown do
    Rails.configuration.hdm.delete(:saml)
  end

  test "#new redirects to SSO" do
    get new_saml_session_path

    assert_redirected_to %r{\Ahttps://testsso}
  end

  test "#create with successful SSO redirects to root_path" do
    stubbed_saml_response(valid: true) do
      post saml_session_path
      assert_redirected_to root_path
    end
  end

  test "#create with failed SSO redirects to login page" do
    stubbed_saml_response(valid: false) do
      post saml_session_path
      assert_redirected_to new_session_path
    end
  end

  private

  def stubbed_saml_response(valid: true, &block)
    saml_response = Minitest::Mock.new
    saml_response.expect(:settings=, true, [OneLogin::RubySaml::Settings])
    saml_response.expect(:is_valid?, valid)
    saml_response.expect(:nameid, "testuser@example.com")
    OneLogin::RubySaml::Response.stub(:new, saml_response, &block)
  end
end
