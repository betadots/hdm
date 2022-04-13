require 'test_helper'

class HieraData::HierarchyTest < ActiveSupport::TestCase
  test "#uses_globs? returns true if `glob` key present" do
    glob = "/*/singular/glob"
    raw_hash = {"name" => "Singular path", "glob" => glob}
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    assert hierarchy.uses_globs?
  end

  test "#uses_globs? returns true if `globs` key present" do
    globs = ["/*/array/globs", "/test/**/globs"]
    raw_hash = {"name" => "Singular path", "globs" => globs}
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    assert hierarchy.uses_globs?
  end

  test "#paths supports the singular `path` setting" do
    path = "/test/singular/path"
    raw_hash = {"name" => "Singular path", "path" => path}
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    assert_equal [path], hierarchy.paths
  end

  test "#paths returns all non-interpolated path names" do
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    expected_paths = [
      "nodes/%{::fqdn}.yaml",
      "role/%{::role}-%{::env}.yaml",
      "role/%{::role}.yaml",
      "zone/%{::zone}.yaml",
      "common.yaml"
    ]
    assert_equal expected_paths, hierarchy.paths
  end

  test "#paths returns an empty array if no data is available" do
    hierarchy = HieraData::Hierarchy.new(raw_hash: {}, base_path: ".")
    assert hierarchy.paths.empty?
  end

  test "#paths supports the singular `glob` setting" do
    glob = "/*/singular/glob"
    raw_hash = {"name" => "Singular path", "glob" => glob}
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    assert_equal [glob], hierarchy.paths
  end

  test "#paths supports the `globs` array setting" do
    globs = ["/*/array/globs", "/test/**/globs"]
    raw_hash = {"name" => "Singular path", "globs" => globs}
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    assert_equal globs, hierarchy.paths
  end

  test "#resolved_paths uses facts to resolve paths" do
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    facts = {
      "fqdn" => "testhost",
      "role" => "hdm_test",
      "env" => "development",
      "zone" => "internal"
    }
    expected_resolved_paths = [
      "nodes/testhost.yaml",
      "role/hdm_test-development.yaml",
      "role/hdm_test.yaml",
      "zone/internal.yaml",
      "common.yaml"
    ]
    assert_equal expected_resolved_paths, hierarchy.resolved_paths(facts: facts)
  end

  test "#resolved_paths resolves globs" do
    base_path = Rails.root.join("test/fixtures/files/puppet/environments/globs")
    globs = ["common/*.yaml"]
    raw_hash = {"name" => "Common", "datadir" => "data", "globs" => globs}
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: base_path)
    facts = {"fqdn" => "testhost"}
    expected_resolved_paths = [
      "common/foobar.yaml",
      "common/hdm.yaml"
    ]
    assert_equal expected_resolved_paths, hierarchy.resolved_paths(facts: facts)
  end

  test "#name returns the existing name" do
    hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
    assert_equal "Yaml hierarchy", hierarchy.name
  end

  def raw_hash
    {
      "name" => "Yaml hierarchy",
      "paths" => [
        "nodes/%{::fqdn}.yaml",
        "role/%{::role}-%{::env}.yaml",
        "role/%{::role}.yaml",
        "zone/%{::zone}.yaml",
        "common.yaml"
      ]
    }
  end

  class HieraData::HierarchyForYamlDataTest < ActiveSupport::TestCase
    test "data_hash specified and yaml" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal :yaml, hierarchy.backend
    end

    def raw_hash
      {
        "name" => "Yaml hierarchy",
        "data_hash" => "yaml_data"
      }
    end
  end

  class HieraData::HierarchyForJSONDataTest < ActiveSupport::TestCase
    test "data_hash specified and json" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal :json, hierarchy.backend
    end

    def raw_hash
      {
        "name" => "JSON hierarchy",
        "data_hash" => "json_data"
      }
    end
  end


  class HieraData::HierarchyForEyamlDataTest < ActiveSupport::TestCase
    setup do
      @tmpdir = Dir.mktmpdir
    end

    teardown do
      FileUtils.remove_entry @tmpdir
    end

    test "lookup function is not data_hash" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal :eyaml, hierarchy.backend
    end

    test "#private_key returns path from options" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal "private.key", hierarchy.private_key.to_s
    end

    test "#public_key returns path from options" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: ".")
      assert_equal "public.key", hierarchy.public_key.to_s
    end

    test "#encryptable? is true if all keys present and readable" do
      tmpdir_path = Pathname.new(@tmpdir)
      %w(private.key public.key).each { |f| FileUtils.touch(tmpdir_path.join(f)) }
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: @tmpdir)

      assert hierarchy.encryptable?
    end

    test "#encryptable? is false if a key is missing" do
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: @tmpdir)

      refute hierarchy.encryptable?
    end

    test "#encryptable? is false if a key is not readable" do
      tmpdir_path = Pathname.new(@tmpdir)
      files = %w(private.key public.key).map { |f| tmpdir_path.join(f) }
      files.each do |path|
        FileUtils.touch(path)
        File.chmod(0000, path)
      end
      hierarchy = HieraData::Hierarchy.new(raw_hash: raw_hash, base_path: @tmpdir)

      refute hierarchy.encryptable?

      File.chmod(0600, *files)
    end

    def raw_hash
      {
        "name" => "EYaml hierarchy",
        "lookup_key" => "eyaml_lookup_key",
        "options" => {
          "pkcs7_private_key" => "private.key",
          "pkcs7_public_key" => "public.key"
        }
      }
    end
  end
end
