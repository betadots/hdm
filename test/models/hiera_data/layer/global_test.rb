require "test_helper"

class HieraData
  module Layer
    class GlobalTest < ActiveSupport::TestCase
      setup do
        @global_layer = HieraData::Layer::Global.new
      end

      test "#name is `global`" do
        assert_equal "global", @global_layer.name
      end

      test "#base_path returns directory of global `hiera.yaml`" do
        assert_equal "/etc/puppetlabs/puppet", @global_layer.base_path.to_s
      end
    end
  end
end
