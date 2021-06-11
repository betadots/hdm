require 'test_helper'

class KeyTest < ActiveSupport::TestCase
  setup do
    @environment = Environment.new("development")
    @node = Node.new(hostname: "testhost", environment: @environment)
  end

  test "create key object" do
    assert Key.new(@environment, @node, "hdm::integer")
  end

  test "two keys are equal when their environment, node and name match" do
    key_one = Key.new(@environment, @node, "hdm::integer")
    key_two = Key.new(@environment, @node, "hdm::integer")
    assert_equal key_one, key_two
  end

  test "two keys are not equal if their environments differ" do
    hdm_environment = Environment.new("hdm")
    key_one = Key.new(@environment, @node, "hdm::integer")
    key_two = Key.new(hdm_environment, @node, "hdm::integer")
    assert_not_equal key_one, key_two
  end

  test "two keys are not equal if their nodes differ" do
    other_node = Node.new(hostname: "testhost2", environment: @environment)
    key_one = Key.new(@environment, @node, "hdm::integer")
    key_two = Key.new(@environment, other_node, "hdm::integer")
    assert_not_equal key_one, key_two
  end

  test "two keys are not equal if their names differ" do
    key_one = Key.new(@environment, @node, "hdm::integer")
    key_two = Key.new(@environment, @node, "hdm::float")
    assert_not_equal key_one, key_two
  end

  test "#to_param should return the name" do
    key = Key.new(@environment, @node, "hdm::integer")
    assert_equal "hdm::integer", key.to_param
  end

  test "#to_s should return the name" do
    key = Key.new(@environment, @node, "hdm::integer")
    assert_equal "hdm::integer", key.to_s
  end

  test "#hierarchies loads all hierarchies" do
    hierarchies = [Hierarchy.new(environment: @environment, name: "test", datadir: Dir.pwd, backend: :yaml, files: [])]
    key = Key.new(@environment, @node, "hdm::integer")
    Hierarchy.stub(:all, hierarchies) do
      assert_equal hierarchies, key.hierarchies
    end
  end

  test "#save_value uses underlying hiera_data object" do
    key = Key.new(@environment, @node, "hdm::integer")
    hiera_data = MiniTest::Mock.new
    hiera_data.expect(:write_key, true, ["hierarchy", "/path", "hdm::integer", 23, {encrypt: false}])
    key.stub(:hiera_data, hiera_data) do
      key.save_value("hierarchy", "/path", "23")
    end
    hiera_data.verify
  end

  test "#remove_value uses underlying hiera_data object" do
    key = Key.new(@environment, @node, "hdm::integer")
    hiera_data = MiniTest::Mock.new
    hiera_data.expect(:remove_key, true, ["hierarchy", "/path", "hdm::integer"])
    key.stub(:hiera_data, hiera_data) do
      key.remove_value("hierarchy", "/path")
    end
    hiera_data.verify
  end
end
