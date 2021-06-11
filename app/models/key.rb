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

  def save_value(hierarchy_name, path, value, encrypt: false)
    value = YAML.load(value)
    hiera_data.write_key(hierarchy_name, path, name, value, encrypt: encrypt)
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

  def to_param
    name
  end

  def to_s
    name
  end

  private

  def hiera_data
    @hiera_data ||= HieraData.new(@environment.name)
  end
end
