require 'test_helper'

class HieraDataTest < ActiveSupport::TestCase
  test "create for environment" do
    assert HieraData.new('development')
  end

  test "raise error for unknown environment" do
    err = assert_raises(HieraData::EnvironmentNotFound) { HieraData.new('unknown') }
    assert_match("Environment 'unknown' does not exist", err.message)
  end

  test "#search_key return all hierarchies and files that contains the key" do
    hiera = HieraData.new('development')
    expected_result = {
      "Eyaml hierarchy" =>
      [
        { path: "nodes/testhost.yaml",            file_present: true,  key_present: true, value: "hostname: hostname\n"  },
        { path: "role/hdm_test-development.yaml", file_present: false,  key_present: false, value: nil  },
        { path: "role/hdm_test.yaml",             file_present: true, key_present: true, value: "hostname: hostname-role\n" },
        { path: "zone/internal.yaml",             file_present: false, key_present: false, value: nil },
        { path: "common.yaml",                    file_present: true,  key_present: true, value: "hostname: common::hostname\n"  }
      ]
    }

    node = Node.new("testhost")
    facts = node.facts(environment: "development")
    result = hiera.search_key(facts , 'psick::firstrun::linux_classes')
    assert_equal ["Eyaml hierarchy"], result.keys
    assert_equal 5, result["Eyaml hierarchy"].size
    assert_equal expected_result["Eyaml hierarchy"][0], result["Eyaml hierarchy"][0], "element 1"
    assert_equal expected_result["Eyaml hierarchy"][1], result["Eyaml hierarchy"][1], "element 2"
    assert_equal expected_result["Eyaml hierarchy"][2], result["Eyaml hierarchy"][2], "element 3"
    assert_equal expected_result["Eyaml hierarchy"][3], result["Eyaml hierarchy"][3], "element 4"
    assert_equal expected_result["Eyaml hierarchy"][4], result["Eyaml hierarchy"][4], "element 5"
  end

  test "#all_keys return all keys" do
    hiera = HieraData.new('development')
    expected_result = [
        "hdm::float", "hdm::integer", "noop_mode", "psick::enable_firstrun", "psick::firstrun::linux_classes", "psick::postfix::tp::resources_hash", "psick::time::servers", "psick::timezone"
    ]

    node = Node.new("testhost")
    result = hiera.all_keys(node.facts(environment: "development"))
    assert_equal expected_result, result
  end

  test "#write_key goes fine for the first one" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {"test_key"=>"true"}
      hiera = HieraData.new('development')
      hiera.write_key("Eyaml hierarchy", 'nodes/writehost.yaml', 'test_key', 'true')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  test "#write_key goes fine for the second one" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {"abc" => "def", "test_key"=>"true"}
      hiera = HieraData.new('development')
      hiera.write_key("Eyaml hierarchy", 'nodes/writehost.yaml', 'test_key', 'true')
      hiera.write_key("Eyaml hierarchy", 'nodes/writehost.yaml', 'abc', 'def')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  test "#remove_key goes fine" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {}
      hiera = HieraData.new('development')
      hiera.remove_key("Eyaml hierarchy", 'nodes/writehost.yaml', 'test_key')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end
end
