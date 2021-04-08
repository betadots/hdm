require 'test_helper'

class EnvironmentTest < ActiveSupport::TestCase
  test "list the environments" do
    expected_environments = %w(
      development
      hdm
      minimal
      multiple_hierarchies
      no_config
      test
      v3
    )
    assert_equal expected_environments, Environment.all_names
  end

  test "create development environment" do
    assert Environment.new('development')
  end

  test "raise error for non existing environment" do
    err = assert_raises(Environment::NotFound) { Environment.new('unknown') }
    assert_match("Environment 'unknown' does not exist", err.message)
  end
end
