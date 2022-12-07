require "test_helper"

class GroupTest < ActiveSupport::TestCase
  class ValidationsTest < ActiveSupport::TestCase
    setup do
      @group = Group.new
      @group.rules = [/a/]
    end

    test "name needs to be present" do
      @group.restrict = "environment"
      assert_not @group.valid?
      @group.name = "test"
      assert @group.valid?
    end

    %w[environment node key].each do |restrictable|
      test "#{restrictable} rules need to be valid regexps" do
        @group.name = "regexp test"
        @group.restrict = restrictable
        assert @group.valid?
        @group.rules = ["*"]
        assert_not @group.valid?
      end
    end
  end
end
