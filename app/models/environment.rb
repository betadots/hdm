class Environment < HieraModel
  attribute :name, :string
  attribute :in_use, :boolean, default: false
  attribute :available, :boolean, default: false

  def self.all
    environments_in_use = PuppetDbClient.environments
    available_environments = HieraData.environments
    all_environments = {}
    environments_in_use.sort.each do |e|
      all_environments[e] = { name: e, in_use: true }
    end
    available_environments.sort.each do |e|
      all_environments[e] ||= { name: e }
      all_environments[e][:available] = true
    end
    all_environments.map { |_, attributes| new(**attributes) }
  end

  def self.find(name)
    all.find { |e| e.name == name }
  end

  def hierarchies
    Hierarchy.all(self)
  end

  def in_use?
    in_use
  end

  def available?
    available
  end

  def ==(other)
    other.is_a?(Environment) && name == other.name
  end

  def to_param
    name
  end

  def to_s
    name
  end
end
