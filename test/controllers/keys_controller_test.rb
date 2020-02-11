require 'test_helper'

class KeysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @data_dir = File.join(Settings.config_dir, 'environments', 'test', 'data')
    @role_dir = File.join(@data_dir, 'role')
    FileUtils.mkdir_p(@role_dir)
    File.write(File.join(@data_dir, "common.yaml"), {}.to_yaml)
    File.write(File.join(@role_dir, "hdm_test.yaml"), {}.to_yaml)
  end

  teardown do
    FileUtils.rm_rf(@data_dir)
  end

  test "#create the key, add it to common file" do
    path = File.join(@data_dir, 'common.yaml')

    post keys_url, params: { id: "new_key", value: "" }, as: :json
    assert_equal ["id"], json.keys
    expected_hash = {"new_key" => ''}
    assert_equal expected_hash, YAML.load(File.read(path))
  end

  test "#update the key if is valid json" do
    path = File.join(@role_dir, 'hdm_test.yaml')

    patch key_url('psick::enable_firstrun'), params: key_params, as: :json
    assert_equal ["id"], json.keys
    expected_hash = {"psick::enable_firstrun" => true}
    assert_equal expected_hash, YAML.load(File.read(path))
  end

  test "#update the key if is valid json (array)" do
    path = File.join(@role_dir, 'hdm_test.yaml')

    patch key_url('psick::enable_firstrun'), params: key_params.merge("value" => ["a", "b"].to_json), as: :json
    assert_equal ["id"], json.keys
    expected_hash = {"psick::enable_firstrun" => ["a", "b"]}
    assert_equal expected_hash, YAML.load(File.read(path))
  end

  test "#update return erro if is not valid json" do
    patch key_url('psick::enable_firstrun'), params: key_params.merge!("value" => "!@#"), as: :json
    assert_equal ["errors"], json.keys
    assert_equal ["value"], json["errors"].keys
    assert_equal ["specified value for key is not a valid YAML"], json["errors"]["value"]
  end

  test "#delete the key" do
    path = File.join(@role_dir, 'hdm_test.yaml')

    delete key_url('psick::enable_firstrun'), params: {path: "role/hdm_test.yaml"}, as: :json
    assert_response :no_content
    expected_hash = {}
    assert_equal expected_hash, YAML.load(File.read(path))
  end

  private
    def keys_url(environment: 'test', node: 'testhost')
      "/environments/#{environment}/nodes/#{node}/keys"
    end

    def key_url(key, environment: 'test', node: 'testhost')
      "/environments/#{environment}/nodes/#{node}/keys/#{key}"
    end

    def key_params
      {
        path: "role/hdm_test.yaml",
        value: "true"
       }
    end
end
