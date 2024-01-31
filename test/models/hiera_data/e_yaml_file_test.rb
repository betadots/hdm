require 'test_helper'

class HieraData
  class EYamlFileTest < ActiveSupport::TestCase
    test "::encrypted? detects encrypted values" do
      assert_equal false, EYamlFile.encrypted?("string")

      assert_equal true, EYamlFile.encrypted?(ciphertext)
    end

    test "::decrypt_value can decrypt a value" do
      assert_equal "top secret", EYamlFile.decrypt_value(ciphertext, public_key:, private_key:)
    end

    test "::encrypt_value can encrypt values" do
      encrypted_value = EYamlFile.encrypt_value("top secret", public_key:, private_key:)

      assert_match /\AENC\[.+\]\z/, encrypted_value
      assert_no_match /top secret/, encrypted_value
    end

    test "#content can decrypt top level encrypted values" do
      file = EYamlFile.new(
        path: config_dir.join("common.yaml"),
        options: {
          public_key:, private_key: , decrypt: true
        }
      )

      assert_equal "c8hoduj5", file.content["c8hoduj5"].chomp
    end

    private

    def ciphertext
      "ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEAe2qPOZxi519fmMyaH47BN1oEnDcluk5ec0jlugSzyInd3v2qirncMYVcAvjg2ckjhWX4h458ZJJuDpT5+ediNG+OQ/BAO+QgjHu7eAR8imjBmeFbjN+dl90y4Lh0S4b/ihpcJ8N9qASWvCePmKafjwFaKNjc6Dws05OQ+G/oBIiXGkXJsE6kbT1qX9DrovHEO6Ve2dANUYmiw1oC8cyqSPi8aBeDdBmZJCQyDrx37QTXf8+b0aVAMG4KPEI1vdoO10ElAsof8Mwx60HkUCCSXRZ2fACp5ODf+hgg9B7Z4eFRxIf4VuqPI+b4pcvPRS/PExI2E99YXIyJz86DD7KPFjA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBAgGnfhv3yX43m4aHwqBAB9gBAHgnAZ17HQe3wMCQ2pPuh8]"
    end

    def config_dir
      Pathname.new(Rails.configuration.hdm["config_dir"]).join('environments', 'eyaml', 'data')
    end

    def public_key
      Rails.root.join("test/fixtures/files/puppet/environments/eyaml/keys/public_key.pkcs7.pem")
    end

    def private_key
      Rails.root.join("test/fixtures/files/puppet/environments/eyaml/keys/private_key.pkcs7.pem")
    end
  end
end
