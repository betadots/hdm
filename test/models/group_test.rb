require "test_helper"

class GroupTest < ActiveSupport::TestCase
  class ValidationsTest < ActiveSupport::TestCase
    setup do
      @group = Group.new
    end

    test "name needs to be present" do
      refute @group.valid?
      @group.name = "test"
      assert @group.valid?
    end

    test "allows only one default group" do
      Group.create!(name: "default", default: true)
      @group.name = "other default"
      @group.default = true

      refute @group.valid?
    end

    [:environment_pattern, :node_pattern, :key_pattern].each do |pattern|
      test "#{pattern} needs to be a valid regexp" do
        @group.name = "regexp test"
        assert @group.valid?
        @group.send(:"#{pattern}=", "*")
        refute @group.valid?
      end
    end
  end

  test "::default returns the default group" do
    default_group = Group.create!(name: "default", default: true)
    assert_equal default_group, Group.default
  end
end
