require 'test_helper'

class HieraData
  class ConfigTest < ActiveSupport::TestCase
    class ConfigV3 < ActiveSupport::TestCase
      test "does not support v3 config style" do
        assert_raise Hdm::Error do
          HieraData::Config.new(base_path.join("hiera.yaml"))
        end
      end

      def base_path
        Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "v3")
      end
    end

    class ConfigNoYamlFilePresent < ActiveSupport::TestCase
      test "uses defaults from puppet" do
        config = HieraData::Config.new(base_path.join("hiera.yaml"))
        assert_equal 1, config.hierarchies.size
      end

      def base_path
        Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "no_config")
      end
    end

    class ConfigMinimalIncompleteYamlFile < ActiveSupport::TestCase
      test "merges with defaults from puppet" do
        config = HieraData::Config.new(base_path.join("hiera.yaml"))
        assert_equal 1, config.hierarchies.size
      end

      def base_path
        Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "minimal")
      end
    end

    class ConfigNoDatadirInYamlFile < ActiveSupport::TestCase
      test "uses default datadir from puppet" do
        config = HieraData::Config.new(base_path.join("hiera.yaml"))
        assert_not_nil config.content["defaults"]
        assert_equal Puppet::Pops::Lookup::HieraConfigV5::DEFAULT_CONFIG_HASH["defaults"]["datadir"], config.content["defaults"]["datadir"]
      end

      def base_path
        Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "no_datadir")
      end
    end

    class ConfigWithSomeHierarchiesTest < ActiveSupport::TestCase
      test "when only defaults, return the yaml paths" do
        config = HieraData::Config.new(base_path.join("hiera.yaml"))
        assert_equal 3, config.hierarchies.size
      end

      def base_path
        Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "multiple_hierarchies")
      end
    end

    class ConfigWithEmptyDefaultsTest < ActiveSupport::TestCase
      test "empty defaults get replaced" do
        config = HieraData::Config.new(base_path.join("hiera.yaml"))
        assert_not_nil config.content["defaults"]
        assert_equal Puppet::Pops::Lookup::HieraConfigV5::DEFAULT_CONFIG_HASH["defaults"], config.content["defaults"]
      end

      def base_path
        Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "empty_defaults")
      end
    end
  end
end
