class Node < HieraModel
  attribute :hostname, :string
  attribute :environment
  alias name hostname

  def self.all(environment: nil)
    node_records = PuppetDbClient.nodes(environment: environment&.name)
    environments = Environment.all.group_by(&:name) unless environment
    node_records.map do |node_record|
      env = environment || environments[node_record["environment"]].first
      new(hostname: node_record["certname"], environment: env)
    end
  end

  def self.find(hostname)
    all.find { |n| n.hostname == hostname }
  end

  def ==(other)
    other.is_a?(Node) &&
      hostname == other.hostname &&
      environment == other.environment
  end

  def facts
    @facts ||=
      PuppetDbClient.facts(certname: hostname)
  end

  def to_param
    hostname
  end

  def to_s
    hostname
  end
end
