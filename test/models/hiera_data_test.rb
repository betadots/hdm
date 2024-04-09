require 'test_helper'

class HieraDataTest < ActiveSupport::TestCase
  test "create for environment" do
    assert HieraData.new(environment: 'development')
  end

  test "#all_keys return all keys" do
    hiera = HieraData.new(environment: 'development')
    expected_result = [
      "classes", "foobar::enable_firstrun", "foobar::firstrun::linux_classes", "foobar::postfix::tp::resources_hash", "foobar::time::servers", "foobar::timezone", "hdm::float", "hdm::integer", "noop_mode"
    ]

    node = Node.new(hostname: "testhost", environment: "development")
    result = hiera.all_keys(facts: node.facts)
    assert_equal expected_result, result
  end

  test "#lookup returns the correct result for the given environment and facts" do
    hiera = HieraData.new(environment: "lookup_tests")
    node = Node.new(hostname: "lookup.betadots.training", environment: "lookup_tests")
    expected = %w[node role zone common]

    assert_equal expected, hiera.lookup(key: "hdm_duplicates_in_array", facts: node.facts)
  end

  test "#lookup_options_for can use hash syntax" do
    hiera = HieraData.new(environment: "lookup_tests")

    assert_equal "deep", hiera.lookup_options_for(key: "hash_syntax")
  end

  test "#lookup_options_for favors literal match over regexp" do
    hiera = HieraData.new(environment: "lookup_tests")

    assert_equal "unique", hiera.lookup_options_for(key: "hdm_duplicates_in_array")
  end

  test "#lookup_options_for uses first regexp match if no literal match possible" do
    hiera = HieraData.new(environment: "lookup_tests")

    assert_equal "hash", hiera.lookup_options_for(key: "hdm_duplicates_hash")
  end

  test "#lookup_options_for defaults to first" do
    hiera = HieraData.new(environment: "lookup_tests")

    assert_equal "first", hiera.lookup_options_for(key: "hdm_integer")
  end
end
