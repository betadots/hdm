class HieraData
  class EnvironmentNotFound < StandardError; end

  attr_reader :environment

  def initialize(environment)
    @environment = environment

    raise EnvironmentNotFound.new("Environment '#{environment}' does not exist") unless PuppetDbClient.environments.include?(environment)
  end

  def all_keys(facts)
    keys = []
    config_file.hierarchies.each do |hierarchy|
      hierarchy.paths.each do |path|
        file = ReadFile.new(config_dir: data_path, path: path, facts: facts)
        keys.concat(file.keys)
      end
    end
    keys.sort.uniq
  end

  def search_key(facts, key)
    search_results = {}
    config_file.hierarchies.each do |hierarchy|
      search_results[hierarchy.name] = []
      hierarchy.paths.map do |path|
        file = ReadFile.new(config_dir: data_path, path: path, facts: facts)
        if file.fact_matched
          search_results[hierarchy.name] << {
            path: file.calculated_path,
            present: file.exist?,
            key_present: file.keys.include?(key),
            value: file.content_for_key(key)
          }
        end
      end
    end
    search_results
  end

  def write_key(path, key, value)
    read_file = ReadFile.new(config_dir: data_path, path: path, facts: {})
    read_file.write_key(key, value)
  end

  def remove_key(path, key)
    read_file = ReadFile.new(config_dir: data_path, path: path, facts: {})
    read_file.remove_key(key)
  end

  private

  def config_dir
    @config_dir ||= Rails.configuration.hdm["config_dir"]
  end

  def data_path
    Pathname.new(config_dir).join("environments", environment, "data")
  end

  def config_file
    @config_file ||= ConfigFile.new(Pathname.new(config_dir).join("environments", environment))
  end
end
