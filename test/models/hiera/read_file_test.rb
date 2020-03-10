require 'test_helper'

class Hiera::ReadFileTest < ActiveSupport::TestCase
  test "full path" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "role/%{::role}-%{::env}.yaml", facts: facts)
    assert_equal File.join(Settings.config_dir, "environments/development/data/role/hdm_test-development.yaml"), file.full_path
  end

  test "#exit? return false for non existing file" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "role/%{::role}-%{::env}.yaml", facts: facts)
    refute file.exist?
  end

  test "#exit? return true for existing file" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "nodes/%{::fqdn}.yaml", facts: facts)
    assert file.exist?
  end

  test "#calculated_path return the name interpolated with facts" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "nodes/%{::fqdn}.yaml", facts: facts)
    assert_equal "nodes/testhost.yaml", file.calculated_path
  end

  test "#keys return the top level keys for the file" do
    expected_keys = [
      "noop_mode",
      "psick::enable_firstrun",
      "psick::firstrun::linux_classes",
      "psick::time::servers",
      "psick::timezone",
      "psick::postfix::tp::resources_hash"
    ]

    file = Hiera::ReadFile.new(config_dir: config_dir, path: "nodes/%{::fqdn}.yaml", facts: facts)
    assert_equal expected_keys, file.keys
  end

  test "#keys return empty array for non existing file" do
    expected_keys = []

    file = Hiera::ReadFile.new(config_dir: config_dir, path: "unknown_file.yaml", facts: facts)
    assert_equal expected_keys, file.keys
  end

  test "#content_for_key return nil for unknown file and key" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "unknown_file", facts: facts)
    assert_nil file.content_for_key('noop_mode')

    file = Hiera::ReadFile.new(config_dir: config_dir, path: "nodes/%{::fqdn}.yaml", facts: facts)
    assert_nil file.content_for_key('unknown_key')
  end

  test "#content_for_key return true (as string) for boolean" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "nodes/%{::fqdn}.yaml", facts: facts)
    assert_equal "true", file.content_for_key('noop_mode')
  end

  test "#content_for_key return string for string" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "nodes/%{::fqdn}.yaml", facts: facts)
    assert_equal "CET", file.content_for_key('psick::timezone')
  end

  test "#content_for_key return yaml structure as string" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "nodes/%{::fqdn}.yaml", facts: facts)
    assert_equal key_as_string, file.content_for_key('psick::postfix::tp::resources_hash')
  end

  test "#content_for_key returns integer as integer" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "common.yaml", facts: facts)
    assert_equal 1, file.content_for_key('hdm::integer')
  end

  test "#content_for_key returns float as float" do
    file = Hiera::ReadFile.new(config_dir: config_dir, path: "common.yaml", facts: facts)
    assert_equal 0.1, file.content_for_key('hdm::float')
  end

  test "#write_key goes fine" do
    path = Rails.root.join('test', 'fixtures', 'files', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {"test_key"=>"true"}
      file = Hiera::ReadFile.new(config_dir: config_dir, path: "nodes/writehost.yaml", facts: {})
      file.write_key('test_key', 'true')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  test "#remove_key goes fine" do
    path = Rails.root.join('test', 'fixtures', 'files', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {}
      file = Hiera::ReadFile.new(config_dir: config_dir, path: "nodes/writehost.yaml", facts: {})
      file.remove_key('test_key')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  private
    def config_dir
      Pathname.new(Settings.config_dir).join('environments', 'development', 'data')
    end

    def facts
      {
        "fqdn" => "testhost",
        "role" => "hdm_test",
        "env" => "development",
        "zone" => "internal"
      }
    end

    def key_as_string
      <<~HEREDOC
      tp::conf:
        postfix:
          template: psick/postfix/main.cf.epp
      HEREDOC
    end
end
