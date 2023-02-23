require 'test_helper'

class SamlTest < ActiveSupport::TestCase
  test "::configured? checks if configuration exists" do
    Rails.configuration.hdm[:saml] = SAML_TEST_CONFIG.dup
    assert Saml.configured?
    Rails.configuration.hdm.delete(:saml)
    assert_not Saml.configured?
  end

  test "#settings correctly configures ruby-saml" do
    Rails.configuration.hdm[:saml] = SAML_TEST_CONFIG.dup
    settings = Saml.new.settings
    assert_equal "hdm-test", settings.sp_entity_id
    assert_equal "https://testsso", settings.idp_sso_service_url
    assert_equal "test", settings.idp_cert_fingerprint
    assert_equal "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress", settings.name_identifier_format
    Rails.configuration.hdm.delete(:saml)
  end
end
