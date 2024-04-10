require 'test_helper'

class HieraData
  class LayerTest < ActiveSupport::TestCase
    class NoGlobalLayerPresentTest < ActiveSupport::TestCase
      def setup
        @config = Rails.configuration.hdm
        @original_global_hiera_yaml = @config[:global_hiera_yaml]
        @config[:global_hiera_yaml] = "/tmp/does/not/exist/hiera.yaml"
      end

      def teardown
        @config[:global_hiera_yaml] = @original_global_hiera_yaml
      end

      test "::self_for does not find a global layer" do
        layers = HieraData::Layer.for(environment: "development")

        assert_equal 1, layers.size
        assert_equal "environment", layers.first.name
      end
    end

    class GlobalLayerPresentTest < ActiveSupport::TestCase
      def setup
        @config = Rails.configuration.hdm
        @original_global_hiera_yaml = @config[:global_hiera_yaml]
        @config[:global_hiera_yaml] = Rails.root.join("test/fixtures/files/puppet/global/hiera.yaml").to_s
      end

      def teardown
        @config[:global_hiera_yaml] = @original_global_hiera_yaml
      end

      test "::self_for finds a global layer" do
        layers = HieraData::Layer.for(environment: "development")

        assert_equal 2, layers.size
        assert_equal "global", layers.first.name
      end
    end
  end
end
