require 'test_helper'

class HieraData
  class HierarchyTest < ActiveSupport::TestCase
    test "#uses_globs? returns true if `glob` key present" do
      glob = "/*/singular/glob"
      raw_hash = { "name" => "Singular path", "glob" => glob }
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
      assert hierarchy.uses_globs?
    end

    test "#uses_globs? returns true if `globs` key present" do
      globs = ["/*/array/globs", "/test/**/globs"]
      raw_hash = { "name" => "Singular path", "globs" => globs }
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
      assert hierarchy.uses_globs?
    end

    test "#paths supports the singular `path` setting" do
      path = "/test/singular/path"
      raw_hash = { "name" => "Singular path", "path" => path }
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
      assert_equal [path], hierarchy.paths
    end

    test "#paths returns all non-interpolated path names" do
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
      expected_paths = [
        "nodes/%{::facts.fqdn}.yaml",
        "role/%{::facts.role}-%{::facts.env}.yaml",
        "role/%{::facts.role}.yaml",
        "zone/%{::facts.zone}.yaml",
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
      raw_hash = { "name" => "Singular path", "glob" => glob }
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
      assert_equal [glob], hierarchy.paths
    end

    test "#paths supports the `globs` array setting" do
      globs = ["/*/array/globs", "/test/**/globs"]
      raw_hash = { "name" => "Singular path", "globs" => globs }
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
      assert_equal globs, hierarchy.paths
    end

    test "#resolved_paths uses facts to resolve paths" do
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
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
      assert_equal expected_resolved_paths, hierarchy.resolved_paths(facts:)
    end

    test "#resolved_paths resolves globs" do
      base_path = Rails.root.join("test/fixtures/files/puppet/environments/globs")
      globs = ["common/*.yaml"]
      raw_hash = { "name" => "Common", "datadir" => "data", "globs" => globs }
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path:)
      facts = { "fqdn" => "testhost" }
      expected_resolved_paths = [
        "common/foobar.yaml",
        "common/hdm.yaml"
      ]
      assert_equal expected_resolved_paths, hierarchy.resolved_paths(facts:)
    end

    test "#resolved_paths resolves globs when given a dynamic datadir" do
      base_path = Rails.root.join("test/fixtures/files/puppet/environments/dynamic_datadir")
      globs = ["c*.yaml"]
      raw_hash = { "name" => "Common", "datadir" => "%{facts.custom.datadir}", "globs" => globs }
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path:)
      facts = { "custom" => { "datadir" => "data1" }  }
      expected_resolved_paths = [
        "common.yaml"
      ]
      assert_equal expected_resolved_paths, hierarchy.resolved_paths(facts:)
    end

    test "#name returns the existing name" do
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
      assert_equal "Yaml hierarchy", hierarchy.name
    end

    test "#candidate_files returns files matching paths with variables replaced by globs" do
      base_path = Rails.root.join("test/fixtures/files/puppet/environments/multiple_hierarchies")
      hierarchy = HieraData::Hierarchy.new(
        raw_hash: raw_hash.merge("datadir" => "data"),
        base_path:
      )
      expected_candidate_files = [
        "nodes/4msusyei.betadots.training.yaml",
        "nodes/60wxmaw5.betadots.training.yaml",
        "nodes/test.host.yaml",
        "role/hdm_test.yaml",
        "zone/internal.yaml",
        "common.yaml"
      ].map { |f| File.join(base_path, "data", f) }
      assert_equal expected_candidate_files, hierarchy.candidate_files
    end

    test "#datadir uses facts to resolve datadir" do
      raw_hash = {
        "name" => "dynamic datadir",
        "datadir" => "%{facts.datadir}"
      }
      facts = { "datadir" => "data1" }
      base_path = Rails.root.join("test/fixtures/files/puppet/environments/dynamic_datadir")
      hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path:)

      assert_equal base_path.join("data1"), hierarchy.datadir(facts:)
    end

    test "#decrypt_value can decrypt values" do
      base_path = Rails.root.join("test/fixtures/files/puppet/environments/eyaml")
      hierarchy = HieraData::Hierarchy.new(raw_hash: eyaml_raw_hash, base_path:)
      ciphertext = "ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEAe2qPOZxi519fmMyaH47BN1oEnDcluk5ec0jlugSzyInd3v2qirncMYVcAvjg2ckjhWX4h458ZJJuDpT5+ediNG+OQ/BAO+QgjHu7eAR8imjBmeFbjN+dl90y4Lh0S4b/ihpcJ8N9qASWvCePmKafjwFaKNjc6Dws05OQ+G/oBIiXGkXJsE6kbT1qX9DrovHEO6Ve2dANUYmiw1oC8cyqSPi8aBeDdBmZJCQyDrx37QTXf8+b0aVAMG4KPEI1vdoO10ElAsof8Mwx60HkUCCSXRZ2fACp5ODf+hgg9B7Z4eFRxIf4VuqPI+b4pcvPRS/PExI2E99YXIyJz86DD7KPFjA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBAgGnfhv3yX43m4aHwqBAB9gBAHgnAZ17HQe3wMCQ2pPuh8]"

      assert_equal "top secret", hierarchy.decrypt_value(value: ciphertext)
    end

    test "#encrypt_value can encrypt values" do
      base_path = Rails.root.join("test/fixtures/files/puppet/environments/eyaml")
      hierarchy = HieraData::Hierarchy.new(raw_hash: eyaml_raw_hash, base_path:)
      ciphertext = hierarchy.encrypt_value(value: "top secret")

      assert_match(/\AENC\[.+\]\z/, ciphertext)
      assert_no_match(/top secret/, ciphertext)
    end

    def raw_hash
      {
        "name" => "Yaml hierarchy",
        "paths" => [
          "nodes/%{::facts.fqdn}.yaml",
          "role/%{::facts.role}-%{::facts.env}.yaml",
          "role/%{::facts.role}.yaml",
          "zone/%{::facts.zone}.yaml",
          "common.yaml"
        ]
      }
    end

    def eyaml_raw_hash
      {
        "lookup_key" => "eyaml_lookup_key",
        "options" => {
          "pkcs7_private_key" => "keys/private_key.pkcs7.pem",
          "pkcs7_public_key" => "keys/public_key.pkcs7.pem"
        }
      }
    end

    class HierarchyForYamlDataTest < ActiveSupport::TestCase
      test "data_hash specified and yaml" do
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
        assert_equal :yaml, hierarchy.backend
      end

      def raw_hash
        {
          "name" => "Yaml hierarchy",
          "data_hash" => "yaml_data"
        }
      end
    end

    class HierarchyForJSONDataTest < ActiveSupport::TestCase
      test "data_hash specified and json" do
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
        assert_equal :json, hierarchy.backend
      end

      def raw_hash
        {
          "name" => "JSON hierarchy",
          "data_hash" => "json_data"
        }
      end
    end

    class HierarchyForEyamlDataTest < ActiveSupport::TestCase
      setup do
        @tmpdir = Dir.mktmpdir
      end

      teardown do
        FileUtils.remove_entry @tmpdir
      end

      test "lookup function is not data_hash" do
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
        assert_equal :eyaml, hierarchy.backend
      end

      test "#private_key returns path from options" do
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
        assert_equal "private.key", hierarchy.private_key.to_s
      end

      test "#public_key returns path from options" do
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
        assert_equal "public.key", hierarchy.public_key.to_s
      end

      test "#encryptable? is true if all keys present and readable" do
        tmpdir_path = Pathname.new(@tmpdir)
        %w[private.key public.key].each { |f| FileUtils.touch(tmpdir_path.join(f)) }
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: @tmpdir)

        assert hierarchy.encryptable?
      end

      test "#encryptable? is false if a key is missing" do
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: @tmpdir)

        assert_not hierarchy.encryptable?
      end

      test "#encryptable? is false if a key is not readable" do
        tmpdir_path = Pathname.new(@tmpdir)
        files = %w[private.key public.key].map { |f| tmpdir_path.join(f) }
        files.each do |path|
          FileUtils.touch(path)
          File.chmod(0o000, path)
        end
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: @tmpdir)

        assert_not hierarchy.encryptable?

        File.chmod(0o600, *files)
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

    class HierarchyForCustomBackend < ActiveSupport::TestCase
      test "custom lookup function specified but no mapping present" do
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
        assert_raises Hdm::Error do
          hierarchy.backend
        end
      end

      test "custom lookup function mapped to eyaml" do
        Rails.configuration.hdm[:custom_lookup_function_mapping] = {
          custom_eyaml_function: "eyaml"
        }
        hierarchy = HieraData::Hierarchy.new(raw_hash:, base_path: ".")
        assert_equal :eyaml, hierarchy.backend
        Rails.configuration.hdm.delete(:custom_lookup_function_mapping)
      end

      def raw_hash
        {
          "name" => "JSON hierarchy",
          "lookup_key" => "custom_eyaml_function"
        }
      end
    end
  end
end
