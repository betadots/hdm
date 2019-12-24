require 'test_helper'

class KeysControllerTest < ActionDispatch::IntegrationTest
  test "#create the key, add it to common file" do
    path = Rails.root.join('test', 'fixtures', 'files', 'environments', 'test', 'data', 'common.yaml')

    with_temp_file(path) do
      post keys_url, params: { id: "new_key", value: "" }, as: :json
      assert_equal ["id"], json.keys
      expected_hash = {"new_key" => ''}
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  test "#update the key if is valid json" do
    path = Rails.root.join('test', 'fixtures', 'files', 'environments', 'test', 'data', 'role', 'hdm_test.yaml')

    with_temp_file(path) do
      patch key_url('psick::enable_firstrun'), params: key_params, as: :json
      assert_equal ["id"], json.keys
      expected_hash = {"psick::enable_firstrun" => true}
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  test "#update the key if is valid json (array)" do
    path = Rails.root.join('test', 'fixtures', 'files', 'environments', 'test', 'data', 'role', 'hdm_test.yaml')

    with_temp_file(path) do
      patch key_url('psick::enable_firstrun'), params: key_params.merge("value" => ["a", "b"].to_json), as: :json
      assert_equal ["id"], json.keys
      expected_hash = {"psick::enable_firstrun" => ["a", "b"]}
      assert_equal expected_hash, YAML.load(File.read(path))
    end
  end

  test "#update return erro if is not valid json" do
    patch key_url('psick::enable_firstrun'), params: key_params.merge!("value" => "!@#"), as: :json
    assert_equal ["errors"], json.keys
    assert_equal ["value"], json["errors"].keys
    assert_equal ["specified value for key is not a valid YAML"], json["errors"]["value"]
  end

  test "#delete the key" do
    path = Rails.root.join('test', 'fixtures', 'files', 'environments', 'test', 'data', 'role', 'hdm_test.yaml')

    with_temp_file(path) do
      delete key_url('psick::enable_firstrun'), params: {path: "role/hdm_test.yaml"}, as: :json
      assert_response :no_content
      expected_hash = {}
      assert_equal expected_hash, YAML.load(File.read(path))
    end
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
