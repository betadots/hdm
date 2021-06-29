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

    refute hierarchy.encryption_possible?
  end

  test "#encryption_possible? is false for non-eyaml hierarchies" do
    hierarchy = create_hierarchy(backend: :yaml)

    refute hierarchy.encryption_possible?
  end

  test "#encryption_possible? is false if hierarchy is not encryptable" do
    hierarchy = create_hierarchy(encryptable: false)

    refute hierarchy.encryption_possible?
  end

  private

  def create_hierarchy(backend: :eyaml, encryptable: true)
    Hierarchy.new(
      environment: "eyaml",
      name: "Global data",
      datadir: ".",
      backend: backend,
      files: [],
      encryptable: encryptable
    )
  end
end
