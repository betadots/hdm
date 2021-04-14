require 'test_helper'

class HieraData::ConfigFileTest < ActiveSupport::TestCase
  class HieraData::ConfigFileV3 < ActiveSupport::TestCase
    test "does not support v3 config style" do
      assert_raise Hdm::Error do
        HieraData::ConfigFile.new(base_path)
      end
    end

    def base_path
      Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "v3")
    end
  end
  class HieraData::ConfigFileNoYamlFilePresent < ActiveSupport::TestCase
    test "uses defaults from puppet" do
      config = HieraData::ConfigFile.new(base_path)
      assert_equal 1, config.hierarchies.size
    end

    def base_path
      Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "no_config")
    end
  end

  class HieraData::ConfigFileMinimalIncompleteYamlFile < ActiveSupport::TestCase
    test "merges with defaults from puppet" do
      config = HieraData::ConfigFile.new(base_path)
      assert_equal 1, config.hierarchies.size
    end

    def base_path
      Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "minimal")
    end
  end

  class HieraData::ConfigFileWithSomeHierarchiesTest < ActiveSupport::TestCase
    test "when only defaults, return the yaml paths" do
      config = HieraData::ConfigFile.new(base_path)
      assert_equal 2, config.hierarchies.size
    end

    def base_path
      Pathname.new(Rails.configuration.hdm["config_dir"]).join("environments", "multiple_hierarchies")
    end
  end
end
