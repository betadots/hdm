require 'test_helper'

class DataFileTest < ActiveSupport::TestCase
  setup do
    @original_environment = Environment.new(name: "development")
    @node = Node.new(environment: @original_environment, hostname: "test.host")
    @globs_environment = Environment.new(name: "globs")
    @path = "role/hdm_test.yaml"
  end

  test "#has_differing_value_in_original_environment? returns false if environments are the same" do
    layer = @original_environment.environment_layer
    hierarchy = Hierarchy.find(layer:, name: "Eyaml hierarchy")
    data_file = hierarchy.file(node: @node, path: @path)
    key = Key.new(name: "hdm::integer")

    assert_not data_file.has_differing_value_in_original_environment?(node: @node, key:)
  end

  test "#has_differing_value_in_original_environment? returns false if original environment has no file with the same path" do
    layer = @globs_environment.environment_layer
    hierarchy = Hierarchy.find(layer:, name: "Common")
    data_file = hierarchy.file(node: @node, path: "common/foobar.yaml")
    key = Key.new(name: "hdm::integer")

    assert_not data_file.has_differing_value_in_original_environment?(node: @node, key:)
  end

  test "#has_differing_value_in_original_environment? returns false if original environment's value is the same" do
    layer = @globs_environment.environment_layer
    hierarchy = Hierarchy.find(layer:, name: "Eyaml hierarchy")
    data_file = hierarchy.file(node: @node, path: @path)
    key = Key.new(name: "hdm::integer")

    assert_not data_file.has_differing_value_in_original_environment?(node: @node, key:)
  end

  test "#has_differing_value_in_original_environment? returns true if original environment's value is different" do
    layer = @globs_environment.environment_layer
    hierarchy = Hierarchy.find(layer:, name: "Eyaml hierarchy")
    data_file = hierarchy.file(node: @node, path: @path)
    key = Key.new(name: "hdm::float")

    assert data_file.has_differing_value_in_original_environment?(node: @node, key:)
  end

  test "#value_for returns matching value from given environment" do
    layer = @globs_environment.environment_layer
    hierarchy = Hierarchy.find(layer:, name: "Eyaml hierarchy")
    data_file = hierarchy.file(node: @node, path: @path)
    key = Key.new(name: "hdm::float")

    assert_equal "4.5", data_file.value_for(key:).value
  end

  test "#value_from_original_environment returns matching value from the node's original environment" do
    layer = @globs_environment.environment_layer
    hierarchy = Hierarchy.find(layer:, name: "Eyaml hierarchy")
    data_file = hierarchy.file(node: @node, path: @path)
    key = Key.new(name: "hdm::float")

    assert_equal "2.3", data_file.value_from_original_environment(node: @node, key:).value
  end
end
