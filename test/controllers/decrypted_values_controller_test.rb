require "test_helper"

class DecryptedValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @allow_encryption = Rails.configuration.hdm["allow_encryption"]
    Rails.configuration.hdm["allow_encryption"] = true

    sign_in_as(users(:user))
  end

  teardown do
    Rails.configuration.hdm["allow_encryption"] = @allow_encryption
  end

  test "POST :create" do
    post environment_layer_hierarchy_decrypted_values_path("eyaml", "environment", "Global data"), params: { value: }

    assert_response :success
  end

  private

  def value
    <<~ENCRYPTED
      ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBAD
      AFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEAwyIydM05wi88kHdKFMI9frO1d+
      e/h1c/s5PuOcPGsNr01BxSIIBbZf8nakNzX2rB7g15hQsB9Qeo0MIy2mcS/i
      nCcsknT+hjuZIP4+qmxWzgShrX8W7NWuHPTHA+D05RaxVbXa2Pzyp6SO1lYq
      nGAeTRh4xsJ7x9UJ2JC5U6FORqGflirj4OJm3e4HmKSddqiIZIquGERzU8Wl
      pMeZ4SP7VhBshpMpLVTtaEy4sjVu3VU0V331h0+/dHTQ5PhWNabsABH1G32G
      esT9wHD1617DvnUahV+eVuxLDrPYb9zxvTbt6Q+I7ShEyFmOJnuCWbVIjELR
      v5OjQDzH3clqqaKjA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBBmexdYaQ
      5dUtmd8tkvIH1QgBAX7Zy6UO4dxPDDIltKM1Mn]
    ENCRYPTED
  end
end
