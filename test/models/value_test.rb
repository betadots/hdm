require "test_helper"

class ValueTest < ActiveSupport::TestCase
  setup do
    @environment = Environment.new(name: "development")
    @hierarchy = Hierarchy.find(@environment, "Eyaml hierarchy")
    @data_file = DataFile.new(hierarchy: @hierarchy, path: "common.yaml")
    @key = Key.new(name: "test::dummy", environment: @environment)
    @value = Value.new(data_file: @data_file, key: @key)
  end

  test "#update uses underlying hiera_data object" do
    hiera_data = Minitest::Mock.new
    hiera_data.expect(:write_key, true, ["Eyaml hierarchy", "common.yaml", "test::dummy", 23], facts: {})
    @value.stub(:hiera_data, hiera_data) do
      @value.update("23")
    end
    hiera_data.verify
  end

  test "#destroy uses underlying hiera_data object" do
    hiera_data = Minitest::Mock.new
    hiera_data.expect(:remove_key, true, ["Eyaml hierarchy", "common.yaml", "test::dummy"], facts: {})
    @value.stub(:hiera_data, hiera_data) do
      @value.destroy
    end
    hiera_data.verify
  end
end
