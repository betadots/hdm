class Node
  class NotFound < StandardError; end

  attr_reader :hostname, :environment

  def self.all_names(environment:)
    PuppetDbClient.nodes(environment: environment)
  end

  def self.all(environment:)
    all_names(environment: environment).map do |hostname|
      new(hostname: hostname, environment: environment)
    end
  end

  def initialize(hostname: , environment:)
    @hostname = hostname
    @environment = environment
  end

  def ==(other)
    other.is_a?(Node) &&
      hostname == other.hostname &&
      environment == other.environment
  end

  def facts
    @facts ||=
      PuppetDbClient.facts(certname: hostname, environment: @environment)
  end

  def to_param
    hostname
  end

  def to_s
    hostname
  end
end
