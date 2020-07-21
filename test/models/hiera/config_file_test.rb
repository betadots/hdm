require 'test_helper'

class Hiera::ConfigFileTest < ActiveSupport::TestCase
  class Hiera::ConfigFileWithDefaultDataTest < ActiveSupport::TestCase
    test "when only defaults, return the yaml paths" do
      config = Hiera::ConfigFile.new(hiera_file)
      assert config.version5?
      assert config.default_yaml_data?
      assert config.hierarchies.empty?
    end

    def hiera_file
      YAML.load(
        <<~EOF
        version: 5
        defaults:
          datadir: data
          data_hash: yaml_data
        EOF
      )
    end
  end

  class Hiera::ConfigFileWithSomeEnvironmentsTest < ActiveSupport::TestCase
    test "when only defaults, return the yaml paths" do
      config = Hiera::ConfigFile.new(hiera_file)
      assert config.version5?
      assert config.default_yaml_data?
      assert_equal 2, config.hierarchies.size
    end

    def hiera_file
      YAML.load(
        <<~EOF
        version: 5
        defaults:
          datadir: data
          data_hash: yaml_data
        
        hierarchy:
          - name: "Per-datacenter business group data" # Uses custom facts.
            path: "location/%{facts.whereami}/%{facts.group}.yaml"
        
          - name: "Global business group data"
            path: "groups/%{facts.group}.yaml"
        EOF
      )
    end
  end
end
