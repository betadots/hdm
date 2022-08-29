class Environment < HieraModel
  attribute :name, :string

  def self.all_names
    PuppetDbClient.environments
  end

  def self.all
    all_names.map { |e| new(name: e) }
  end

  def self.find(name)
    new(name: name)
  end

  def hierarchies
    Hierarchy.all(self)
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
