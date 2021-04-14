require 'test_helper'

class HieraData::ReadFileTest < ActiveSupport::TestCase
  test "#exist? return false for non existing file" do
    file = HieraData::ReadFile.new(path: config_dir.join("role/hdm_test-development.yaml"))
    refute file.exist?
  end

  test "#exist? return true for existing file" do
    file = HieraData::ReadFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert file.exist?
  end

  test "#keys returns the top level keys for the file" do
    expected_keys = [
      "noop_mode",
      "psick::enable_firstrun",
      "psick::firstrun::linux_classes",
      "psick::time::servers",
      "psick::timezone",
      "psick::postfix::tp::resources_hash"
    ]

    file = HieraData::ReadFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_equal expected_keys, file.keys
  end

  test "#keys returns empty array for non existing file" do
    expected_keys = []
    file = HieraData::ReadFile.new(path: config_dir.join("role/hdm_test-development.yaml"))

    assert_equal expected_keys, file.keys
  end

  test "#content_for_key returns nil for unknown file and key" do
    file = HieraData::ReadFile.new(path: config_dir.join("role/hdm_test-development.yaml"))
    assert_nil file.content_for_key('noop_mode')

    file = HieraData::ReadFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_nil file.content_for_key('unknown_key')
  end

  test "#content_for_key returns true (as string) for boolean" do
    file = HieraData::ReadFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_equal "true", file.content_for_key('noop_mode')
  end

  test "#content_for_key returns string for string" do
    file = HieraData::ReadFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_equal "CET", file.content_for_key('psick::timezone')
  end

  test "#content_for_key returns yaml structure as string" do
    file = HieraData::ReadFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_equal key_as_string, file.content_for_key('psick::postfix::tp::resources_hash')
  end

  test "#content_for_key returns integer as integer" do
    file = HieraData::ReadFile.new(path: config_dir.join("common.yaml"))
    assert_equal 1, file.content_for_key('hdm::integer')
  end

  test "#content_for_key returns float as float" do
    file = HieraData::ReadFile.new(path: config_dir.join("common.yaml"))
    assert_equal 0.1, file.content_for_key('hdm::float')
  end

  test "#write_key goes fine" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {"test_key"=>"true"}
      file = HieraData::ReadFile.new(path: path)
      file.write_key('test_key', 'true')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  test "#remove_key goes fine" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {}
      file = HieraData::ReadFile.new(path: path)
      file.remove_key('test_key')
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  private
    def config_dir
      Pathname.new(Rails.configuration.hdm["config_dir"]).join('environments', 'development', 'data')
    end

    def key_as_string
      <<~HEREDOC
      tp::conf:
        postfix:
          template: psick/postfix/main.cf.epp
      HEREDOC
    end
end
