require 'test_helper'

class HieraDataTest < ActiveSupport::TestCase
  test "create for environment" do
    assert HieraData.new('development')
  end

  test "raise error for unknown environment" do
    err = assert_raises(HieraData::EnvironmentNotFound) { HieraData.new('unknown') }
    assert_match("Environment 'unknown' does not exist", err.message)
  end

  test "#paths return lookup paths" do
    hiera = HieraData.new('development')
    existing_paths = {
      "Eyaml hierarchy" =>
      [
        "nodes/%{::fqdn}.yaml",
        "role/%{::role}-%{::env}.yaml",
        "role/%{::role}.yaml",
        "zone/%{::zone}.yaml",
        "common.yaml"
      ]
    }
    assert_equal existing_paths, hiera.paths
  end

  test "#needs_facts return which facts are expected" do
    hiera = HieraData.new('development')
    expected_facts = [
      "::env",
      "::fqdn",
      "::role",
      "::zone",
    ]
    assert_equal expected_facts, hiera.expected_facts
  end

  test "#find_key return all hierarchies and files that contains the key" do
    hiera = HieraData.new('development')
    expected_result = {
      "Eyaml hierarchy" =>
      [
        { path: "nodes/testhost.yaml",            present: true,  key_present: true, value: "hostname: hostname\n"  },
        { path: "role/hdm_test-development.yaml", present: false,  key_present: false, value: nil  },
        { path: "role/hdm_test.yaml",             present: true, key_present: true, value: "hostname: hostname-role\n" },
        { path: "zone/internal.yaml",             present: false, key_present: false, value: nil },
        { path: "common.yaml",                    present: true,  key_present: true, value: "hostname: common::hostname\n"  }
      ]
    }

    result = hiera.search_key('testhost', 'psick::firstrun::linux_classes')
    assert_equal ["Eyaml hierarchy"], result.keys
    assert_equal 5, result["Eyaml hierarchy"].size
    assert_equal expected_result["Eyaml hierarchy"][0], result["Eyaml hierarchy"][0], "element 1"
    assert_equal expected_result["Eyaml hierarchy"][1], result["Eyaml hierarchy"][1], "element 2"
    assert_equal expected_result["Eyaml hierarchy"][2], result["Eyaml hierarchy"][2], "element 3"
    assert_equal expected_result["Eyaml hierarchy"][3], result["Eyaml hierarchy"][3], "element 4"
    assert_equal expected_result["Eyaml hierarchy"][4], result["Eyaml hierarchy"][4], "element 5"
  end

  test "#all_keys return all keys, in the hierarchy and ready to list" do
    hiera = HieraData.new('development')
    expected_result = {
      "_all_keys" => [
        "hdm::float", "hdm::integer", "noop_mode", "psick::enable_firstrun", "psick::firstrun::linux_classes", "psick::postfix::tp::resources_hash", "psick::time::servers", "psick::timezone"
      ],
      "Eyaml hierarchy" =>
      [
        { path: "nodes/testhost.yaml",            present: true, keys: ["noop_mode", "psick::enable_firstrun", "psick::firstrun::linux_classes", "psick::time::servers", "psick::timezone", "psick::postfix::tp::resources_hash"] },
        { path: "role/hdm_test-development.yaml", present: false, keys: [] },
        { path: "role/hdm_test.yaml",             present: true, keys: ["psick::firstrun::linux_classes"] },
        { path: "zone/internal.yaml",             present: false, keys: [] },
        { path: "common.yaml",                    present: true, keys: ["hdm::float", "hdm::integer", "psick::enable_firstrun", "psick::firstrun::linux_classes", "psick::time::servers", "psick::timezone", "psick::postfix::tp::resources_hash"] }
      ]
    }

    result = hiera.all_keys('testhost')
    assert_equal expected_result.keys, result.keys
    assert_equal expected_result["_all_keys"], result["_all_keys"]

    assert_equal 5, result["Eyaml hierarchy"].size
    assert_equal expected_result["Eyaml hierarchy"][0], result["Eyaml hierarchy"][0], "element 1"
    assert_equal expected_result["Eyaml hierarchy"][1], result["Eyaml hierarchy"][1], "element 2"
    assert_equal expected_result["Eyaml hierarchy"][2], result["Eyaml hierarchy"][2], "element 3"
    assert_equal expected_result["Eyaml hierarchy"][3], result["Eyaml hierarchy"][3], "element 4"
    assert_equal expected_result["Eyaml hierarchy"][4], result["Eyaml hierarchy"][4], "element 5"
  end

  test "#write_key goes fine for the first one" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {"test_key"=>"true"}
      hiera = HieraData.new('development')
      hiera.write_key('nodes/writehost.yaml', 'test_key', 'true')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  test "#write_key goes fine for the second one" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {"abc" => "def", "test_key"=>"true"}
      hiera = HieraData.new('development')
      hiera.write_key('nodes/writehost.yaml', 'test_key', 'true')
      hiera.write_key('nodes/writehost.yaml', 'abc', 'def')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  test "#remove_key goes fine" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {}
      hiera = HieraData.new('development')
      hiera.remove_key('nodes/writehost.yaml', 'test_key')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end
end
