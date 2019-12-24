class Hiera
  class EnvironmentNotFound < StandardError; end

  attr_reader :environment

  def initialize(environment)
    @environment = environment

    raise EnvironmentNotFound.new("Environment '#{environment}' does not exist") unless Environment.all.include?(environment)
  end

  def paths
    paths = {}
    config_file.environments.each { |x| paths[x.name] = x.paths }
    paths
  end

  def expected_facts
    expected_facts = []
    config_file.environments.map { |x| expected_facts.concat(x.expected_facts) }
    expected_facts.sort.uniq
  end

  def all_keys(node)
    node = Node.new(node)
    search_results = {"_all_keys" => []}
    paths.each_pair do |hiera_env, paths|
      search_results[hiera_env] = []
      paths.map do |path|
        file = ReadFile.new(config_dir: data_path, path: path, facts: node.facts(environment: environment))
        search_results[hiera_env] << {
          path: file.calculated_path,
          present: file.exist?,
          keys: file.keys,
        }
        search_results["_all_keys"].concat(file.keys)
      end
    end
    search_results["_all_keys"].sort!.uniq!
    search_results
  end

  def search_key(node, key)
    node = Node.new(node)
    search_results = {}
    paths.each_pair do |hiera_env, paths|
      search_results[hiera_env] = []
      paths.map do |path|
        file = ReadFile.new(config_dir: data_path, path: path, facts: node.facts(environment: environment))
        if file.fact_matched
          search_results[hiera_env] << {
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
    def content
      @content ||= YAML.load(
        File.read(Pathname.new(Settings.config_dir).join(environment, "hiera.yaml"))
      )
    end

    def data_path
      Pathname.new(Settings.config_dir).join(environment, "data")
    end

    def config_file
      @config_file ||= ConfigFile.new(content)
    end
end
