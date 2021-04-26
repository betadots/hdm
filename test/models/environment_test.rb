require 'test_helper'

class EnvironmentTest < ActiveSupport::TestCase
  test "list the environments" do
    expected_environments = %w(
      development
      eyaml
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

  test "do not raise error when skipping validations" do
    assert_nothing_raised do
      Environment.new('unknown', skip_validation: true)
    end
  end

  test "environments with same name are equal" do
    development_one = Environment.new("development")
    development_two = Environment.new("development")
    assert_equal development_one, development_two
  end

  test "environments with different names are not equal" do
    development_one = Environment.new("development")
    development_two = Environment.new("hdm")
    assert_not_equal development_one, development_two
  end

  test "#to_param returns the name" do
    development = Environment.new("development")
    assert_equal "development", development.to_param
  end

  test "#to_s returns the name" do
    development = Environment.new("development")
    assert_equal "development", development.to_s
  end
end
