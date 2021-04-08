class Environment
  class NotFound < StandardError; end

  attr_reader :name

  def self.all_names
    PuppetDbClient.environments
  end

  def self.all
    all_names.map { |e| new(e, skip_validation: true) }
  end

  def self.find(name)
    new(name)
  end

  def initialize(name, skip_validation: false)
    @name = name

    raise NotFound.new("Environment '#{name}' does not exist") unless skip_validation || Environment.all_names.include?(name)
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
