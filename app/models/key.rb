class Key
  attr_reader :name, :environment, :node

  def self.all(environment, node)
    facts = node.facts
    HieraData.new(environment.name).all_keys(facts)
      .map { |name| new(environment, node, name) }
  end

  def initialize(environment, node, name)
    @environment = environment
    @node = node
    @name = name
  end

  def hierarchies
    @hierarchies ||= Hierarchy.all(@environment, @node)
  end

  def save_value(hierarchy_name, path, value)
    value = YAML.load(value)
    hiera_data.write_key(hierarchy_name, path, name, value)
  end

  def remove_value(hierarchy_name, path)
    hiera_data.remove_key(hierarchy_name, path, name)
  end

  def ==(other)
    other.is_a?(Key) && (
      name == other.name &&
      environment == other.environment &&
      node == other.node
    )
  end

  def lookup_options
    @lookup_options ||= load_lookup_options
  end

  def to_param
    name
  end

  def to_s
    name
  end

  private

  def load_lookup_options
    result = hiera_data.lookup_options(@node.facts).find do |key, options|
      key == name || name.match(Regexp.new("\A#{key}\z"))
    end
    merge = result&.last&.dig("merge")
    case merge
    when String
      merge
    when Hash
      merge["stategy"]
    else
      "first"
    end
  end

  def hiera_data
    @hiera_data ||= HieraData.new(@environment.name)
  end
end
