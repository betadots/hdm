require 'test_helper'

class HieraDataTest < ActiveSupport::TestCase
  test "create for environment" do
    assert HieraData.new('development')
  end

  test "raise error for unknown environment" do
    err = assert_raises(HieraData::EnvironmentNotFound) { HieraData.new('unknown') }
    assert_match("Environment 'unknown' does not exist", err.message)
  end

  test "#search_key returns key data for all given files" do
    hiera = HieraData.new('development')
    expected_result = {
      "nodes/testhost.yaml" => {file_present: true,  file_writable: true, replaced_from_git: false, key_present: true, value: "hostname: hostname\n"},
      "role/hdm_test-development.yaml" => {file_present: false,  file_writable: true, replaced_from_git: false, key_present: false, value: nil},
      "role/hdm_test.yaml" => {file_present: true, file_writable: true, replaced_from_git: false, key_present: true, value: "hostname: hostname-role\n"},
      "zone/internal.yaml" => {file_present: false, file_writable: false, replaced_from_git: false, key_present: false, value: nil },
      "common.yaml" => {file_present: true,  file_writable: true, replaced_from_git: false, key_present: true, value: "hostname: common::hostname\n"}
    }
    facts = {"fqdn" => "testhost", "role" => "hdm_test", "env" => "development", "zone" => "internal"}

    result = hiera.search_key(hiera.hierarchies.first.name, 'foobar::firstrun::linux_classes', facts:)
    assert_equal expected_result, result
  end

  test "#all_keys return all keys" do
    hiera = HieraData.new('development')
    expected_result = [
        "classes", "foobar::enable_firstrun", "foobar::firstrun::linux_classes", "foobar::postfix::tp::resources_hash", "foobar::time::servers", "foobar::timezone", "hdm::float", "hdm::integer", "noop_mode"
    ]

    node = Node.new(hostname: "testhost", environment: "development")
    result = hiera.all_keys(node.facts)
    assert_equal expected_result, result
  end

  test "#write_key goes fine for the first one" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {"test_key"=>"true"}
      hiera = HieraData.new('development')
      hiera.write_key("Eyaml hierarchy", 'nodes/writehost.yaml', 'test_key', 'true')
      assert_equal expected_hash, YAML.load_file(path)
    end
  end

  test "#write_key goes fine for the second one" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {"abc" => "def", "test_key"=>"true"}
      hiera = HieraData.new('development')
      hiera.write_key("Eyaml hierarchy", 'nodes/writehost.yaml', 'test_key', 'true')
      hiera.write_key("Eyaml hierarchy", 'nodes/writehost.yaml', 'abc', 'def')
      assert_equal expected_hash, YAML.load_file(path)
    end
  end

  test "#remove_key goes fine" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {}
      hiera = HieraData.new('development')
      hiera.remove_key("Eyaml hierarchy", 'nodes/writehost.yaml', 'test_key')
      assert_equal expected_hash, YAML.load_file(path)
    end
  end

  test "#decrypt_value can decrypt values" do
    hiera = HieraData.new("eyaml")
    ciphertext = "ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEAe2qPOZxi519fmMyaH47BN1oEnDcluk5ec0jlugSzyInd3v2qirncMYVcAvjg2ckjhWX4h458ZJJuDpT5+ediNG+OQ/BAO+QgjHu7eAR8imjBmeFbjN+dl90y4Lh0S4b/ihpcJ8N9qASWvCePmKafjwFaKNjc6Dws05OQ+G/oBIiXGkXJsE6kbT1qX9DrovHEO6Ve2dANUYmiw1oC8cyqSPi8aBeDdBmZJCQyDrx37QTXf8+b0aVAMG4KPEI1vdoO10ElAsof8Mwx60HkUCCSXRZ2fACp5ODf+hgg9B7Z4eFRxIf4VuqPI+b4pcvPRS/PExI2E99YXIyJz86DD7KPFjA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBAgGnfhv3yX43m4aHwqBAB9gBAHgnAZ17HQe3wMCQ2pPuh8]"

    assert_equal "top secret", hiera.decrypt_value("Global data", ciphertext)
  end

  test "#encrypt_value can encrypt values" do
    hiera = HieraData.new("eyaml")
    ciphertext = hiera.encrypt_value("Global data", "top secret")

    assert_match /\AENC\[.+\]\z/, ciphertext
    assert_no_match /top secret/, ciphertext
  end

  test "#files_including returns file information for a given key" do
    hiera = HieraData.new("multiple_hierarchies")
    expected_result = [
      {
        path: "nodes/test.host.yaml",
        hierarchy_name: "Host specific",
        hierarchy_backend: :yaml,
        value: "CET"
      },
      {
        path: "common.yaml",
        hierarchy_name: "Global data",
        hierarchy_backend: :yaml,
        value: "UTC"
      }
    ]

    assert_equal expected_result, hiera.files_including("foobar::timezone")
  end

  test "#lookup returns the correct result for the given environment and facts" do
    hiera = HieraData.new("lookup_tests")
    node = Node.new(hostname: "lookup.betadots.training", environment: "lookup_tests")
    expected = %w[node role zone common]

    assert_equal expected, hiera.lookup("hdm_duplicates_in_array", facts: node.facts)
  end

  test "#lookup_options_for can use hash syntax" do
    hiera = HieraData.new("lookup_tests")

    assert_equal "deep", hiera.lookup_options_for("hash_syntax")
  end

  test "#lookup_options_for favors literal match over regexp" do
    hiera = HieraData.new("lookup_tests")

    assert_equal "unique", hiera.lookup_options_for("hdm_duplicates_in_array")
  end

  test "#lookup_options_for uses first regexp match if no literal match possible" do
    hiera = HieraData.new("lookup_tests")

    assert_equal "hash", hiera.lookup_options_for("hdm_duplicates_hash")
  end

  test "#lookup_options_for defaults to first" do
    hiera = HieraData.new("lookup_tests")

    assert_equal "first", hiera.lookup_options_for("hdm_integer")
  end
end
