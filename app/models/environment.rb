class Environment
  class NotFound < StandardError; end

  def self.all
    PuppetDBClient.environments
  end

  def initialize(environment)
    @environment = environment

    raise NotFound.new("Environment '#{environment}' does not exist") unless Environment.all.include?(environment)
  end

  def name
    @environment
  end
end
