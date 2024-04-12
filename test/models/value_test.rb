require "test_helper"

class ValueTest < ActiveSupport::TestCase
  setup do
    environment = Environment.new(name: "development")
    layer = environment.find_layer(name: "environment")
    @hierarchy = Hierarchy.find(layer:, name: "Eyaml hierarchy")
    @data_file = DataFile.new(hierarchy: @hierarchy, path: "common.yaml")
    @key = Key.new(name: "test::dummy")
    @value = Value.new(data_file: @data_file, key: @key)
  end

  test "#update uses underlying hiera_data object" do
    hiera_file = Minitest::Mock.new
    hiera_file.expect(:write_key, true, ["test::dummy", 23])
    @data_file.stub(:hiera_file, hiera_file) do
      @value.update("23")
    end
    hiera_file.verify
  end

  test "#destroy uses underlying hiera_data object" do
    hiera_file = Minitest::Mock.new
    hiera_file.expect(:remove_key, true, ["common.yaml", "test::dummy"])
    @data_file.stub(:hiera_file, hiera_file) do
      @value.destroy
    end
    hiera_file.verify
  end
end
