require 'test_helper'

class KeyTest < ActiveSupport::TestCase
  setup do
    @environment = Environment.new(name: "development")
    @node = Node.new(hostname: "testhost", environment: @environment)
  end

  test ":all_for puts `lookup_options` first if present" do
    hiera_data = Minitest::Mock.new
    hiera_data.expect(:all_keys, %w(one lookup_options two), [Hash])
    HieraData.stub(:new, hiera_data) do
      keys = Key.all_for(@node)
      key_names = keys.map(&:name)
      assert_equal %w(lookup_options one two), key_names
    end
  end

  test "create key object" do
    assert Key.new(name: "hdm::integer", environment: @environment)
  end

  test "two keys are equal when their environment and name match" do
    key_one = Key.new(name: "hdm::integer", environment: @environment)
    key_two = Key.new(name: "hdm::integer", environment: @environment)
    assert_equal key_one, key_two
  end

  test "two keys are not equal if their environments differ" do
    hdm_environment = Environment.new(name: "hdm")
    key_one = Key.new(name: "hdm::integer", environment: @environment)
    key_two = Key.new(name: "hdm::integer", environment: hdm_environment)
    assert_not_equal key_one, key_two
  end

  test "two keys are not equal if their names differ" do
    key_one = Key.new(name: "hdm::integer", environment: @environment)
    key_two = Key.new(name: "hdm::float", environment: @environment)
    assert_not_equal key_one, key_two
  end

  test "#to_param should return the name" do
    key = Key.new(name: "hdm::integer", environment: @environment)
    assert_equal "hdm::integer", key.to_param
  end

  test "#to_s should return the name" do
    key = Key.new(name: "hdm::integer", environment: @environment)
    assert_equal "hdm::integer", key.to_s
  end
end
