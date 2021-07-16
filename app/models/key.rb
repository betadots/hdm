class Key
  attr_reader :name, :environment, :node

  def self.all(environment, node)
    facts = node.facts
    keys = []
    HieraData.new(environment.name).all_keys(facts)
      .each do |name|
      key = new(environment, node, name)
      if name == "lookup_options"
        keys.unshift(key)
      else
        keys << key
      end
    end
    keys
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
    lookup_option_candidates = hiera_data.lookup_options(@node.facts)
    result = lookup_option_candidates.find do |key, options|
      key == name
    end
    result ||= lookup_option_candidates.find do |key, options|
      name.match(Regexp.new("\\A#{key}\\z"))
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
