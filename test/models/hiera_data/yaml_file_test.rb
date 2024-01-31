require 'test_helper'

class HieraData
  class YamlFileTest < ActiveSupport::TestCase
  test "#exist? return false for non existing file" do
    file = HieraData::YamlFile.new(path: config_dir.join("role/hdm_test-development.yaml"))
    refute file.exist?
  end

  test "#exist? return true for existing file" do
    file = HieraData::YamlFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert file.exist?
  end

  test "#keys returns the top level keys for the file" do
    expected_keys = [
      "noop_mode",
      "classes",
      "foobar::enable_firstrun",
      "foobar::firstrun::linux_classes",
      "foobar::time::servers",
      "foobar::timezone",
      "foobar::postfix::tp::resources_hash"
    ]

    file = HieraData::YamlFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_equal expected_keys, file.keys
  end

  test "#keys returns empty array for non existing file" do
    expected_keys = []
    file = HieraData::YamlFile.new(path: config_dir.join("role/hdm_test-development.yaml"))

    assert_equal expected_keys, file.keys
  end

  test "#content returns empty hash when file is empty" do
    file = HieraData::YamlFile.new(path: config_dir.join("nodes/empty.yaml"))

    assert_equal({}, file.content)
  end

  test "#content_for_key returns nil for unknown file and key" do
    file = HieraData::YamlFile.new(path: config_dir.join("role/hdm_test-development.yaml"))
    assert_nil file.content_for_key('noop_mode')

    file = HieraData::YamlFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_nil file.content_for_key('unknown_key')
  end

  test "#content_for_key returns true (as string) for boolean" do
    file = HieraData::YamlFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_equal "true", file.content_for_key('noop_mode')
  end

  test "#content_for_key returns string for string" do
    file = HieraData::YamlFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_equal "CET", file.content_for_key('foobar::timezone')
  end

  test "#content_for_key returns yaml structure as string" do
    file = HieraData::YamlFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_equal key_as_string, file.content_for_key('foobar::postfix::tp::resources_hash')
  end

  test "#content_for_key returns integer as integer" do
    file = HieraData::YamlFile.new(path: config_dir.join("common.yaml"))
    assert_equal 1, file.content_for_key('hdm::integer')
  end

  test "#content_for_key returns float as float" do
    file = HieraData::YamlFile.new(path: config_dir.join("common.yaml"))
    assert_equal 0.1, file.content_for_key('hdm::float')
  end

  test "#content_for_key returns empty array as array" do
    file = HieraData::YamlFile.new(path: config_dir.join("nodes/testhost.yaml"))
    assert_equal "[]", file.content_for_key('classes')
  end

  test "#write_key goes fine" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {"test_key"=>"true"}
      file = HieraData::YamlFile.new(path:)
      file.write_key('test_key', 'true')
      assert_equal expected_hash, YAML.load_file(path)
    end
  end

  test "#remove_key goes fine" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')

    with_temp_file(path) do
      expected_hash = {}
      file = HieraData::YamlFile.new(path:)
      file.remove_key('test_key')
      assert_equal expected_hash, YAML.load_file(path)
    end
  end

  test "#writable? returns true if file exists and is writable" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'writehost.yaml')
    file = HieraData::YamlFile.new(path:)

    assert file.writable?
  end

  test "#writable? returns true if file does not exist but directory is writable" do
    path = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data', 'nodes', 'does_not_exist.yaml')
    file = HieraData::YamlFile.new(path:)

    assert file.writable?
  end

  test "writable? returns false if file exists but is not writable" do
    Dir.mktmpdir do |tmpdir|
      path = File.join(tmpdir, "test.yaml")
      File.write(path, {"test" => 23}.to_yaml)
      File.chmod(0400, path)
      file = HieraData::YamlFile.new(path:)

      refute file.writable?
    end
  end

    private
    def config_dir
      Pathname.new(Rails.configuration.hdm["config_dir"]).join('environments', 'development', 'data')
    end

    def key_as_string
      <<~HEREDOC.chomp
      tp::conf:
        postfix:
          template: foobar/postfix/main.cf.epp
      HEREDOC
    end
  end
end
