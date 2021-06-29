require 'test_helper'

class HieraData::HierarchyTest < ActiveSupport::TestCase
  test "#paths supports the singular `path` setting" do
    path = "/test/singular/path"
    raw_hash = {"name" => "Singular path", "path" => path}
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    assert_equal [path], hierarchy.paths
  end

  test "#paths returns all non-interpolated path names" do
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    expected_paths = [
      "nodes/%{::fqdn}.yaml",
      "role/%{::role}-%{::env}.yaml",
      "role/%{::role}.yaml",
      "zone/%{::zone}.yaml",
      "common.yaml"
    ]
    assert_equal expected_paths, hierarchy.paths
  end

  test "#paths returns an empty array if no data is available" do
    hierarchy = HieraData::Hierarchy.new(raw_hash: {}, base_path: ".")
    assert hierarchy.paths.empty?
  end

  test "#resolved_paths uses facts to resolve paths" do
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    facts = {
      "fqdn" => "testhost",
      "role" => "hdm_test",
      "env" => "development",
      "zone" => "internal"
    }
    expected_resolved_paths = [
      "nodes/testhost.yaml",
      "role/hdm_test-development.yaml",
      "role/hdm_test.yaml",
      "zone/internal.yaml",
      "common.yaml"
    ]
    assert_equal expected_resolved_paths, hierarchy.resolved_paths(facts: facts)
  end

  test "#name returns the existing name" do
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    assert_equal "Yaml hierarchy", hierarchy.name
  end

  def raw_hash
    {
      "name" => "Yaml hierarchy",
      "paths" => [
        "nodes/%{::fqdn}.yaml",
        "role/%{::role}-%{::env}.yaml",
        "role/%{::role}.yaml",
        "zone/%{::zone}.yaml",
        "common.yaml"
      ]
    }
  end

  class HieraData::HierarchyForYamlDataTest < ActiveSupport::TestCase
    test "data_hash specified and yaml" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal :yaml, hierarchy.backend
    end

    def raw_hash
      {
        "name" => "Yaml hierarchy",
        "data_hash" => "yaml_data"
      }
    end
  end

  class HieraData::HierarchyForJSONDataTest < ActiveSupport::TestCase
    test "data_hash specified and json" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal :json, hierarchy.backend
    end

    def raw_hash
      {
        "name" => "JSON hierarchy",
        "data_hash" => "json_data"
      }
    end
  end


  class HieraData::HierarchyForEyamlDataTest < ActiveSupport::TestCase
    test "lookup function is not data_hash" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal :eyaml, hierarchy.backend
    end

    test "#private_key returns path from options" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal "private.key", hierarchy.private_key.to_s
    end

    test "#public_key returns path from options" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal "public.key", hierarchy.public_key.to_s
    end

    def raw_hash
      {
        "name" => "EYaml hierarchy",
        "lookup_key" => "eyaml_lookup_key",
        "options" => {
          "pkcs7_private_key" => "private.key",
          "pkcs7_public_key" => "public.key"
        }
      }
    end
  end
end
