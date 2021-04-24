require 'test_helper'

class HieraData::ConfigTest < ActiveSupport::TestCase
  class HieraData::ConfigV3 < ActiveSupport::TestCase
    test "does not support v3 config style" do
      assert_raise Hdm::Error do
        HieraData::Config.new(base_path)
      end
    end

    def base_path
      Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "v3")
    end
  end
  class HieraData::ConfigNoYamlFilePresent < ActiveSupport::TestCase
    test "uses defaults from puppet" do
      config = HieraData::Config.new(base_path)
      assert_equal 1, config.hierarchies.size
    end

    def base_path
      Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "no_config")
    end
  end

  class HieraData::ConfigMinimalIncompleteYamlFile < ActiveSupport::TestCase
    test "merges with defaults from puppet" do
      config = HieraData::Config.new(base_path)
      assert_equal 1, config.hierarchies.size
    end

    def base_path
      Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "minimal")
    end
  end

  class HieraData::ConfigWithSomeHierarchiesTest < ActiveSupport::TestCase
    test "when only defaults, return the yaml paths" do
      config = HieraData::Config.new(base_path)
      assert_equal 2, config.hierarchies.size
    end

    def base_path
      Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "multiple_hierarchies")
    end
  end
end
