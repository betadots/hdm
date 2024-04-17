class Layer < HieraModel
  attribute :name
  attribute :description
  attribute :environment
  attribute :hiera_layer

  def self.all(environment:, key: nil)
    environment.hiera_data.layers(key: key&.name).map do |layer|
      new(
        name: layer.name,
        description: layer.description,
        hiera_data: environment.hiera_data,
        hiera_layer: layer,
        environment: layer.name == "environment" ? environment : nil
      )
    end
  end

  def hierarchies
    Hierarchy.all(layer: self)
  end

  def name_and_description
    "#{name.upcase_first} Layer#{" (#{description})" if description}"
  end

  def to_param
    name
  end
end
