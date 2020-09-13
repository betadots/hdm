require 'test_helper'

class Hiera::ConfigFileTest < ActiveSupport::TestCase
  class Hiera::ConfigFileV3 < ActiveSupport::TestCase
    test "does not support v3 config style" do
      assert_raise Hdm::Error do
        Hiera::ConfigFile.new(base_path)
      end
    end

    def base_path
      Pathname.new(Settings.config_dir).join("environments", "v3")
    end
  end
  class Hiera::ConfigFileNoYamlFilePresent < ActiveSupport::TestCase
    test "uses defaults from puppet" do
      config = Hiera::ConfigFile.new(base_path)
      assert config.version5?
      assert config.default_yaml_data?
      assert_equal 1, config.hierarchies.size
    end

    def base_path
      Pathname.new(Settings.config_dir).join("environments", "no_config")
    end
  end

  class Hiera::ConfigFileMinimalIncompleteYamlFile < ActiveSupport::TestCase
    test "merges with defaults from puppet" do
      config = Hiera::ConfigFile.new(base_path)
      assert config.version5?
      assert config.default_yaml_data?
      assert_equal 1, config.hierarchies.size
    end

    def base_path
      Pathname.new(Settings.config_dir).join("environments", "minimal")
    end
  end

  class Hiera::ConfigFileWithSomeHierarchiesTest < ActiveSupport::TestCase
    test "when only defaults, return the yaml paths" do
      config = Hiera::ConfigFile.new(base_path)
      assert config.version5?
      assert config.default_yaml_data?
      assert_equal 2, config.hierarchies.size
    end

    def base_path
      Pathname.new(Settings.config_dir).join("environments", "multiple_hierarchies")
    end
  end
end
