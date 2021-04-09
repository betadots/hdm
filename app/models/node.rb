class Node
  class NotFound < StandardError; end

  attr_reader :hostname

  def self.all_names
    PuppetDbClient.nodes
  end

  def self.all
    all_names.map { |n| new(n, skip_validation: true) }
  end

  def self.find(name)
    new(name)
  end

  def initialize(hostname, skip_validation: false)
    @hostname = hostname

    raise NotFound.new("Node '#{hostname}' does not exist") unless skip_validation || Node.all_names.include?(hostname)
  end

  def ==(other)
    other.is_a?(Node) && hostname == other.hostname
  end

  def facts(environment:)
    environment_name = environment.is_a?(String) ? environment : environment.name
    @facts ||= {}
    @facts[environment_name] ||=
      PuppetDbClient.facts(certname: hostname, environment: environment_name)
  end

  def to_param
    hostname
  end

  def to_s
    hostname
  end
end
