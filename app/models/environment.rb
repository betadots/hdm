class Environment < HieraModel
  attribute :name, :string
  attribute :in_use, :boolean, default: false

  def self.all
    environments_in_use = PuppetDbClient.environments
    available_environments = HieraData.environments
    unused_environments = available_environments - environments_in_use
    environments_in_use.sort.map { |e| new(name: e, in_use: true) } +
      unused_environments.sort.map { |e| new(name: e) }
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
