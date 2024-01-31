require 'test_helper'

class HieraData
  class UtilTest < ActiveSupport::TestCase
    test "::yaml_format converts a hash to yaml and removes leading `---`" do
      hash = { "test" => 23 }

      assert_equal "test: 23", Util.yaml_format(hash)
    end

    test "::yaml_format converts an integer to yaml and removes leading `---`" do
      integer = 23

      assert_equal "23", Util.yaml_format(integer)
    end
  end
end
