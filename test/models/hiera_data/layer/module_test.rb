require "test_helper"

class HieraData
  module Layer
    class ModuleTest < ActiveSupport::TestCase
      setup do
        @module_layer = HieraData::Layer::Module.new(environment: "development", key: "testmod::integer")
      end

      test "#name is `module`" do
        assert_equal "module", @module_layer.name
      end

      test "#description is the module's name" do
        assert_equal "testmod", @module_layer.description
      end

      test "#base_path returns module's directory" do
        assert_equal Rails.root.join("test/fixtures/files/puppet/environments/development/site/testmod"), @module_layer.base_path
      end

      test "#all_keys only returns keys from module's namespace" do
        expected = %w[testmod::float testmod::integer]
        assert_equal expected, @module_layer.all_keys(facts: {})
      end
    end
  end
end
