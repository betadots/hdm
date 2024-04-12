require 'test_helper'

class LayerTest < ActiveSupport::TestCase
  test "#hierarchies loads all hierarchies" do
    environment = Environment.new(name: "development")
    layer = environment.environment_layer
    hierarchies = [Hierarchy.new(layer:, name: "test", backend: :yaml)]
    Hierarchy.stub(:all, hierarchies) do
      assert_equal hierarchies, layer.hierarchies
    end
  end
end
