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

  test "#candidate_files returns an array of matching `DataFile` instances" do
    environment = Environment.new(name: "multiple_hierarchies")
    hierarchy = Hierarchy.find(layer: environment.environment_layer, name: "Per-datacenter business group data")

    candidate_files = hierarchy.candidate_files
    assert_kind_of Array, candidate_files
    assert_not candidate_files.empty?
    candidate_files.each do |file|
      assert_kind_of DataFile, file
    end
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
