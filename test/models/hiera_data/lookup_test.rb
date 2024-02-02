require 'test_helper'

class HieraData
  class LookupTest < ActiveSupport::TestCase
    setup do
      @lookup = HieraData::Lookup.new(hashes)
    end

    test "looking up simple integer with merge strategy `first`" do
      result = perform_lookup("hdm_integer", merge_strategy: :first)
      assert_equal 23, result
    end

    test "looking up simple integer with merge strategy `hash`" do
      assert_raises Hdm::Error do
        perform_lookup("hdm_integer", merge_strategy: :hash)
      end
    end

    test "looking up a simple array with merge strategy `first`" do
      result = perform_lookup("hdm_unique_array", merge_strategy: :first)
      assert_equal ["node"], result
    end

    test "looking up a simple array with merge strategy `unique`" do
      result = perform_lookup("hdm_unique_array", merge_strategy: :unique)
      assert_equal %w[node role zone common], result
    end

    test "looking up an array with duplicates with merge strategy `unique`" do
      result = perform_lookup("hdm_duplicates_in_array", merge_strategy: :unique)
      assert_equal %w[node role zone common], result
    end

    test "looking up a complex nested array with merge strategy `unique`" do
      result = perform_lookup("hdm_nested_array", merge_strategy: :unique)
      expected = [
        "duplicate",
        { "nested_hash" => {
          "node_integer" => 2
        } },
        "from_role",
        { "nested_hash" => {
          "role_integer" => 2
        } },
        "from_common",
        %w[nested list]
      ]
      assert_equal expected, result
    end

    test "looking up a complex nested array with merge strategy `deep`" do
      result = perform_lookup("hdm_nested_array", merge_strategy: :deep)
      expected = [
        "from_common",
        %w[nested list],
        "duplicate",
        "from_role",
        { "nested_hash" => {
          "role_integer" => 2
        } },
        { "nested_hash" => {
          "node_integer" => 2
        } }
      ]
      assert_equal expected, result
    end

    test "looking up a simple hash with merge strategy `first`" do
      result = perform_lookup("hdm_simple_hash", merge_strategy: :first)
      assert_equal({ "origin" => "node" }, result)
    end

    test "looking up a simple hash with merge strategy `hash`" do
      result = perform_lookup("hdm_simple_hash", merge_strategy: :hash)
      expected = {
        "added_by_common" => "common",
        "added_by_zone" => "zone",
        "added_by_role" => "role",
        "origin" => "node"
      }
      assert_equal expected, result
    end

    test "looking up a simple hash with merge strategy `deep`" do
      result = perform_lookup("hdm_simple_hash", merge_strategy: :deep)
      expected = {
        "added_by_common" => "common",
        "added_by_zone" => "zone",
        "added_by_role" => "role",
        "origin" => "node"
      }
      assert_equal expected, result
    end

    test "looking up a nested hash with merge strategy `hash`" do
      result = perform_lookup("hdm_nested_hash", merge_strategy: :hash)
      expected = {
        "origin" => "node",
        "nested_hash" => {
          "integer" => 5
        }
      }
      assert_equal expected, result
    end

    test "looking up a nested hash with merge strategy `deep`" do
      result = perform_lookup("hdm_nested_hash", merge_strategy: :deep)
      expected = {
        "origin" => "node",
        "nested_hash" => {
          "integer" => 5,
          "added_by_common" => "common",
          "added_by_zone" => "zone",
          "added_by_role" => "role"
        }
      }
      assert_equal expected, result
    end

    test "looking up a mixed value key where a hash is on the highest layer with merge strategy `deep`" do
      result = perform_lookup("hdm_mixed_types", merge_strategy: :deep)

      assert_equal({ "from_node" => 23 }, result)
    end

    test "looking up a mixed value key where a hash is on the lowest layer with merge strategy `deep`" do
      result = perform_lookup("hdm_mixed_types2", merge_strategy: :deep)

      assert_equal 23, result
    end

    private

    def perform_lookup(key, merge_strategy:)
      @lookup.lookup(key, merge_strategy:)
    end

    def hashes
      @hashes ||= [
        "nodes/lookup.betadots.training.yaml",
        "role/test_role.yaml",
        "zone/test_zone.yaml",
        "common.yaml"
      ].map { |f| YAML.load_file(base_path.join(f)) }
    end

    def base_path
      Rails.root.join("test/fixtures/files/puppet/environments/lookup_tests/data")
    end
  end
end
