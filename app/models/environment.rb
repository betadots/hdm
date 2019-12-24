class Environment
  class NotFound < StandardError; end

  def self.all
    if Settings.puppet_db.enabled
      PuppetDBClient.environments
    else
      environments_full_path = Dir.glob(Pathname.new(Settings.config_dir).join("environments", "*"))
      environments_full_path.map { |x| File.basename(x) }.sort!
    end
  end

  def initialize(environment)
    @environment = environment

    raise NotFound.new("Environment '#{environment}' does not exist") unless Environment.all.include?(environment)
  end

  def name
    @environment
  end
end
