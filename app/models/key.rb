class Key < HieraModel
  attribute :name, :string

  def self.all_for(node, environment: node.environment)
    facts = node.facts
    keys = []
    environment.hiera_data.all_keys(facts:).each do |name|
      key = new(name:, hiera_data: environment.hiera_data)
      if name == "lookup_options"
        keys.unshift(key)
      else
        keys << key
      end
    end
    keys
  end

  def ==(other)
    other.is_a?(Key) && other.name == name
  end

  def search(environment:)
    result = {}
    environment.layers(key: self).each do |layer|
      result[layer] = {}
      layer.hierarchies.each do |hierarchy|
        result[layer][hierarchy] = {}
        hierarchy.values_for(key: self).each do |value|
          result[layer][hierarchy][value.data_file] = value
        end
      end
    end
    result
  end

  def lookup_options(node)
    @lookup_options ||= load_lookup_options(node)
  end

  def lookup(node)
    hiera_data.lookup(key: name,
                      facts: node.facts,
                      decrypt: Rails.configuration.hdm.allow_encryption)
  end

  def to_param
    name
  end

  def to_s
    name
  end

  private

  def load_lookup_options(node)
    hiera_data.lookup_options_for(key: name, facts: node.facts)
  end
end
