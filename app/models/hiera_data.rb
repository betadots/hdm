# rubocop:disable Metrics/ClassLength
class HieraData
  class EnvironmentNotFound < StandardError; end

  attr_reader :environment

  delegate :hierarchies, to: :config

  def self.environments
    Pathname.new(config_dir)
            .join("environments")
            .glob("*/")
            .map { |p| p.basename.to_s }
  end

  def self.config_dir
    @config_dir ||= Rails.configuration.hdm.config_dir
  end

  def initialize(environment)
    @environment = environment

    raise EnvironmentNotFound, "Environment '#{environment}' does not exist" unless self.class.environments.include?(environment)
  end

  def all_keys(facts)
    keys = []
    config.hierarchies.each do |hierarchy|
      hierarchy.resolved_paths(facts:).each do |path|
        file = DataFile.new(path: hierarchy.datadir(facts:).join(path), facts:)
        keys.concat(file.keys)
      end
    end
    keys.sort.uniq
  end

  def files_for(hierarchy_name, facts: {})
    hierarchy = find_hierarchy(hierarchy_name)
    hierarchy.resolved_paths(facts:)
  end

  def file_attributes(hierarchy_name, path, facts: nil)
    hierarchy = find_hierarchy(hierarchy_name)
    file = DataFile.new(path: hierarchy.datadir(facts:).join(path), facts:)
    {
      exist: file.exist?,
      writable: file.writable?,
      replaced_from_git: file.replaced_from_git?
    }
  end

  def keys_in_file(hierarchy_name, path, facts: nil)
    hierarchy = find_hierarchy(hierarchy_name)
    DataFile.new(path: hierarchy.datadir(facts:).join(path)).keys
  end

  def value_in_file(hierarchy_name, path, key, facts: {})
    hierarchy = find_hierarchy(hierarchy_name)
    file = DataFile.new(path: hierarchy.datadir(facts:).join(path), facts:)
    file.content_for_key(key)
  end

  def search_key(hierarchy_name, key, facts: nil)
    hierarchy = find_hierarchy(hierarchy_name)
    files = facts ? hierarchy.resolved_paths(facts:) : hierarchy.candidate_files
    search_results = {}
    files.each do |path|
      file = DataFile.new(path: hierarchy.datadir(facts:).join(path), facts:)
      search_results[path] = {
        file_present: file.exist?,
        file_writable: file.writable?,
        key_present: file.keys.include?(key), # rubocop:disable Performance/InefficientHashSearch
        replaced_from_git: file.replaced_from_git?,
        value: file.content_for_key(key)
      }
    end
    search_results
  end

  def files_including(key)
    hierarchies.flat_map do |hierarchy|
      search_results = search_key(hierarchy.name, key)
      search_results.map do |path, search_result|
        next unless search_result[:key_present]

        {
          path:,
          hierarchy_name: hierarchy.name,
          hierarchy_backend: hierarchy.backend,
          value: search_result[:value]
        }
      end
    end.compact
  end

  def write_key(hierarchy_name, path, key, value, facts: {})
    hierarchy = find_hierarchy(hierarchy_name)
    read_file = DataFile.new(path: hierarchy.datadir(facts:).join(path), facts:)
    read_file.write_key(key, value)
  end

  def remove_key(hierarchy_name, path, key, facts: {})
    hierarchy = find_hierarchy(hierarchy_name)
    read_file = DataFile.new(path: hierarchy.datadir(facts:).join(path), facts:)
    read_file.remove_key(key)
  end

  def decrypt_value(hierarchy_name, value)
    hierarchy = find_hierarchy(hierarchy_name)
    public_key = hierarchy.public_key
    private_key = hierarchy.private_key
    EYamlFile.decrypt_value(value, public_key:, private_key:)
  end

  def encrypt_value(hierarchy_name, value)
    hierarchy = find_hierarchy(hierarchy_name)
    public_key = hierarchy.public_key
    private_key = hierarchy.private_key
    EYamlFile.encrypt_value(value, public_key:, private_key:)
  end

  def lookup_options_for(key, facts: {}, decrypt: false)
    candidates = lookup_for(facts, decrypt:)
                 .lookup("lookup_options", merge_strategy: :hash)
    merge = extract_merge_value(key, candidates)
    case merge
    when String
      merge
    when Hash
      merge["strategy"]
    else
      "first"
    end
  end

  def lookup(key, facts: {}, decrypt: false)
    merge_strategy = lookup_options_for(key, facts:, decrypt:).to_sym
    lookup_for(facts).lookup(key, merge_strategy:)
  end

  private

  def config
    @config ||= Config.new(Pathname.new(self.class.config_dir)
      .join("environments", environment))
  end

  def find_hierarchy(name)
    config.hierarchies.find { |h| h.name == name }
  end

  def lookup_for(facts, decrypt: false)
    @cached_lookups ||= {}
    @cached_lookups[facts] ||= begin
      hashes = config.hierarchies.flat_map do |hierarchy|
        hierarchy.resolved_paths(facts:).map do |path|
          DataFile.new(
            path: hierarchy.datadir(facts:).join(path),
            type: hierarchy.backend,
            options: hierarchy.file_options.merge({ decrypt: })
          ).content
        end
      end
      Lookup.new(hashes.compact)
    end
  end

  def extract_merge_value(key, candidates)
    result = candidates&.dig(key)
    result ||= candidates&.select { |k, _v| k[0] == "^" }
                         &.find { |k, _v| key.match(Regexp.new(k)) }
                         &.last
    result&.dig("merge")
  end
end
# rubocop:enable Metrics/ClassLength
