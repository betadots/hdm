require "test_helper"

class HieraData
  module Layer
    class EnvironmentTest < ActiveSupport::TestCase
      setup do
        @environment_layer = HieraData::Layer::Environment.new(environment: "development")
      end

      test "#name is `environment`" do
        assert_equal "environment", @environment_layer.name
      end

      test "#description is the environment's name" do
        assert_equal "development", @environment_layer.description
      end

      test "#base_path returns environment's directory" do
        assert_equal Rails.root.join("test/fixtures/files/puppet/environments/development"), @environment_layer.base_path
      end

      test "#all_keys returns all keys from all the environment's hierarchies" do
        expected = %w[
          foobar::enable_firstrun
          foobar::firstrun::linux_classes
          foobar::postfix::tp::resources_hash
          foobar::time::servers
          foobar::timezone
          hdm::float
          hdm::integer
          testmod::integer
        ]
        assert_equal expected, @environment_layer.all_keys(facts: {})
      end
    end
  end
end
