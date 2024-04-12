class Layer < HieraModel
  attribute :name
  attribute :environment
  attribute :hiera_layer

  def self.all(environment: nil)
    hiera_data = environment ? environment.hiera_data : HieraData.new
    hiera_data.layers.map do |layer|
      new(
        name: layer.name,
        hiera_data:,
        hiera_layer: layer,
        environment: layer.name == "environment" ? environment : nil
      )
    end
  end

  def hierarchies
    Hierarchy.all(layer: self)
  end

  def to_param
    name
  end
end
