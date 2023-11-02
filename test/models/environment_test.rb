require 'test_helper'

class EnvironmentTest < ActiveSupport::TestCase
  test "::all lists the environments" do
    expected_environments = %w(
      development
      dynamic_datadir
      empty_defaults
      eyaml
      globs
      hdm
      minimal
      multiple_hierarchies
      no_config
      no_datadir
      test
      v3
      old_unused
    )
    assert_equal expected_environments, Environment.all.map(&:name)
  end

  test "::all correctly marks unavailable environments" do
    PuppetDbClient.stub :environments, ["unavailable"] do
      environments = Environment.all
      unavailable_environment = environments.find { |e| e.name == "unavailable" }
      assert_not unavailable_environment.available?
    end
  end

  test "::find correctly sets the `in_use` flag" do
    development = Environment.find("development")
    assert development.in_use?
    old_unused = Environment.find("old_unused")
    assert_not old_unused.in_use?
  end

  test "create development environment" do
    assert Environment.new(name: 'development')
  end

  test "environments with same name are equal" do
    development_one = Environment.new(name: "development")
    development_two = Environment.new(name: "development")
    assert_equal development_one, development_two
  end

  test "environments with different names are not equal" do
    development_one = Environment.new(name: "development")
    development_two = Environment.new(name: "hdm")
    assert_not_equal development_one, development_two
  end

  test "#to_param returns the name" do
    development = Environment.new(name: "development")
    assert_equal "development", development.to_param
  end

  test "#to_s returns the name" do
    development = Environment.new(name: "development")
    assert_equal "development", development.to_s
  end

  test "#hierarchies loads all hierarchies" do
    environment = Environment.new(name: "development")
    hierarchies = [Hierarchy.new(environment:, name: "test", backend: :yaml)]
    Hierarchy.stub(:all, hierarchies) do
      assert_equal hierarchies, environment.hierarchies
    end
  end
end
