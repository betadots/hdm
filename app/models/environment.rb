class Environment
  class NotFound < StandardError; end

  attr_reader :name

  def self.all_names
    PuppetDbClient.environments
  end

  def self.all
    all_names.map { |e| new(e) }
  end

  def self.find(name)
    new(name)
  end

  def initialize(name)
    @name = name
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
