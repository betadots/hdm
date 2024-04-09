require 'test_helper'

class HierarchyTest < ActiveSupport::TestCase
  setup do
    @allow_encryption = Rails.configuration.hdm["allow_encryption"]
    Rails.configuration.hdm["allow_encryption"] = true
  end

  teardown do
    Rails.configuration.hdm["allow_encryption"] = @allow_encryption
  end

  test "#encryption_possible? is true if all requirements are met" do
    hierarchy = create_hierarchy

    assert hierarchy.encryption_possible?
  end

  test "#encryption_possible? is false if encryption is disabled" do
    Rails.configuration.hdm["allow_encryption"] = false
    hierarchy = create_hierarchy

    assert_not hierarchy.encryption_possible?
  end

  test "#encryption_possible? is false for non-eyaml hierarchies" do
    hierarchy = create_hierarchy(backend: :yaml)

    assert_not hierarchy.encryption_possible?
  end

  test "#encryption_possible? is false if hierarchy is not encryptable" do
    hierarchy = create_hierarchy(encryptable: false)

    assert_not hierarchy.encryption_possible?
  end

  private

  def create_hierarchy(backend: :eyaml, encryptable: true)
    environment = Environment.new(name: "eyaml")
    Hierarchy.new(
      layer: environment.environment_layer,
      name: "Global data",
      backend:,
      encryptable:
    )
  end
end
