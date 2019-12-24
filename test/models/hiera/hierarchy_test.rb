require 'test_helper'

class Hiera::HierarchyTest < ActiveSupport::TestCase
  test "the expected paths" do
    defaults = hiera_file["defaults"]
    hierarchy = hiera_file["hierarchy"][0]
    config = Hiera::Hierarchy.new(hierarchy: hierarchy, default_data_hash: "yaml_data")
    existing_paths = [
      "nodes/%{::fqdn}.yaml",
      "role/%{::role}-%{::env}.yaml",
      "role/%{::role}.yaml",
      "zone/%{::zone}.yaml",
      "common.yaml"
    ]
    assert_equal existing_paths, config.paths


    config = Hiera::Hierarchy.new(hierarchy: {}, default_data_hash: "yaml_data")
    assert config.paths.empty?
  end

  test "the expected facts" do
    defaults = hiera_file["defaults"]
    hierarchy = hiera_file["hierarchy"][0]
    config = Hiera::Hierarchy.new(hierarchy: hierarchy, default_data_hash: "yaml_data")
    expected_facts = [
      "::env",
      "::fqdn",
      "::role",
      "::zone",
    ]
    assert_equal expected_facts, config.expected_facts


    config = Hiera::Hierarchy.new(hierarchy: {}, default_data_hash: "yaml_data")
    assert config.paths.empty?
  end

  test "#name returns the existing name" do
    defaults = hiera_file["defaults"]
    hierarchy = hiera_file["hierarchy"][0]
    config = Hiera::Hierarchy.new(hierarchy: hierarchy, default_data_hash: "yaml_data")
    assert_equal "Yaml hierarchy", config.name
  end

  def hiera_file
    YAML.load(
      <<~EOF
      hierarchy:
        - name: "Yaml hierarchy"
          paths:
            - "nodes/%{::fqdn}.yaml"
            - "role/%{::role}-%{::env}.yaml"
            - "role/%{::role}.yaml"
            - "zone/%{::zone}.yaml"
            - "common.yaml"
      EOF
    )
  end

  class Hiera::HierarchyForYamlDataTest < ActiveSupport::TestCase
    test "if default is yaml and not specificied, is yaml" do
      defaults = hiera_file["defaults"]
      hierarchy = hiera_file["hierarchy"][0]
      config = Hiera::Hierarchy.new(hierarchy: hierarchy, default_data_hash: "yaml_data")
      assert config.yaml?
    end

    def hiera_file
      YAML.load(
        <<~EOF
        hierarchy:
          - name: "Yaml hierarchy"
            paths:
              - "nodes/%{::fqdn}.yaml"
              - "role/%{::role}-%{::env}.yaml"
              - "role/%{::role}.yaml"
              - "zone/%{::zone}.yaml"
              - "common.yaml"
        EOF
      )
    end
  end

  class Hiera::HierarchyForEyamlDataTest < ActiveSupport::TestCase
    test "if default is yaml and not specificied, is yaml" do
      hierarchy = hiera_file["hierarchy"][0]
      config = Hiera::Hierarchy.new(hierarchy: hierarchy, default_data_hash: "yaml_data")
      refute config.yaml?
    end

    def hiera_file
      YAML.load(
        <<~EOF
        hierarchy:
          - name: "Yaml hierarchy"
            lookup_key: eyaml_lookup_key
            paths:
              - "nodes/%{::fqdn}.eyaml"
              - "role/%{::role}-%{::env}.eyaml"
              - "role/%{::role}.eyaml"
              - "zone/%{::zone}.eyaml"
              - "common.eyaml"
        EOF
      )
    end
  end

  class Hiera::HierarchyForSpecificYamlDataTest < ActiveSupport::TestCase
    test "if default is yaml and not specificied, is yaml" do
      hierarchy = hiera_file["hierarchy"][0]
      config = Hiera::Hierarchy.new(hierarchy: hierarchy, default_data_hash: nil)
      assert config.yaml?
    end

    def hiera_file
      YAML.load(
        <<~EOF
        hierarchy:
          - name: "Yaml hierarchy"
            data_hash: yaml_data
            paths:
              - "nodes/%{::fqdn}.eyaml"
              - "role/%{::role}-%{::env}.eyaml"
              - "role/%{::role}.eyaml"
              - "zone/%{::zone}.eyaml"
              - "common.eyaml"
        EOF
      )
    end
  end
end
