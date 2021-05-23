class Node
  class NotFound < StandardError; end

  attr_reader :hostname, :environment

  def self.all_names(environment:)
    PuppetDbClient.nodes(environment: environment)
  end

  def self.all(environment:)
    all_names(environment: environment).map { |n| new(n, skip_validation: true, environment: environment) }
  end

  def self.find(name)
    new(name)
  end

  def initialize(hostname, skip_validation: false, environment:)
    @hostname = hostname

    raise NotFound.new("Node '#{hostname}' does not exist") unless skip_validation || Node.all_names(environment: environment).include?(hostname)
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
