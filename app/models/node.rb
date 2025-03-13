class Node < HieraModel
  ENVIRONMENT_PRIORITY = %w[catalog_environment report_environment facts_environment].freeze

  attribute :hostname, :string
  attribute :environment
  alias name hostname

  def self.all
    node_records = PuppetDbClient.nodes
    environments = Environment.all.group_by(&:name)
    node_records.map do |node_record|
      env_name = node_record.values_at(*ENVIRONMENT_PRIORITY).compact.first
      env = environments[env_name].first
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
