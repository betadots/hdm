class Node
  class NotFound < StandardError; end

  attr_reader :host

  def self.all
    return ["testhost"] unless Settings.puppet_db.enabled
    PuppetDBClient.nodes
  end

  def initialize(host)
    @host = host

    raise NotFound.new("Node '#{host}' does not exist") unless Node.all.include?(host)
  end

  def facts(environment:)
    return @facts if @facts

    if Settings.puppet_db.enabled
      @facts = PuppetDBClient.facts(certname: host, environment: environment)
    else
      @facts = YAML.load(
        File.read(Pathname.new(Settings.config_dir).join("#{host}_facts.yaml"))
      )
    end
  end
end
