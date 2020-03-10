class Node
  class NotFound < StandardError; end

  attr_reader :host

  def self.all
    PuppetDBClient.nodes
  end

  def initialize(host)
    @host = host

    raise NotFound.new("Node '#{host}' does not exist") unless Node.all.include?(host)
  end

  def facts(environment:)
    PuppetDBClient.facts(certname: host, environment: environment)
  end
end
