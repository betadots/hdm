class Key < HieraModel
  attribute :name, :string
  attribute :environment

  def self.all_for(node, environment: node.environment)
    facts = node.facts
    keys = []
    HieraData.new(environment.name).all_keys(facts)
      .each do |name|
      key = new(environment: environment, name: name)
      if name == "lookup_options"
        keys.unshift(key)
      else
        keys << key
      end
    end
    keys
  end

  def ==(other)
    other.is_a?(Key) && (
      name == other.name &&
      environment == other.environment
    )
  end

  def lookup_options(node)
    @lookup_options ||= load_lookup_options(node)
  end

  def to_param
    name
  end

  def to_s
    name
  end

  private

  def load_lookup_options(node)
    lookup_option_candidates = hiera_data.lookup_options(node.facts)
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
end
