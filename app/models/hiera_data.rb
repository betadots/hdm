# rubocop:disable Metrics/ClassLength
class HieraData
  class EnvironmentNotFound < StandardError; end

  attr_reader :environment

  delegate :hierarchies, to: :config

  class << self
    def environments
      Pathname.new(config_dir)
              .join("environments")
              .glob("*/")
              .map { |p| p.basename.to_s }
    end

    private

    def config_dir
      @config_dir ||= Rails.configuration.hdm.config_dir
    end
  end

  def initialize(environment)
    @environment = environment

    raise EnvironmentNotFound, "Environment '#{environment}' does not exist" unless self.class.environments.include?(environment)
  end

  def all_keys(facts)
    keys = []
    config.hierarchies.each do |hierarchy|
      hierarchy.resolved_paths(facts: facts).each do |path|
        file = DataFile.new(path: hierarchy.datadir.join(path), facts: facts)
        keys.concat(file.keys)
      end
    end
    keys.sort.uniq
  end

  def files_for(hierarchy_name, facts: {})
    hierarchy = find_hierarchy(hierarchy_name)
    hierarchy.resolved_paths(facts: facts)
  end

  def file_attributes(hierarchy_name, path, facts: nil)
    hierarchy = find_hierarchy(hierarchy_name)
    file = DataFile.new(path: hierarchy.datadir.join(path), facts: facts)
    {
      exist: file.exist?,
      writable: file.writable?,
      replaced_from_git: file.replaced_from_git?
    }
  end

  def keys_in_file(hierarchy_name, path)
    hierarchy = find_hierarchy(hierarchy_name)
    DataFile.new(path: hierarchy.datadir.join(path)).keys
  end

  def value_in_file(hierarchy_name, path, key, facts: {})
    hierarchy = find_hierarchy(hierarchy_name)
    file = DataFile.new(path: hierarchy.datadir.join(path), facts: facts)
    file.content_for_key(key)
  end

  def search_key(hierarchy_name, key, facts: nil)
    hierarchy = find_hierarchy(hierarchy_name)
    files = facts ? hierarchy.resolved_paths(facts: facts) : hierarchy.candidate_files
    search_results = {}
    files.each do |path|
      file = DataFile.new(path: hierarchy.datadir.join(path), facts: facts)
      search_results[path] = {
        file_present: file.exist?,
        file_writable: file.writable?,
        key_present: file.keys.include?(key),
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
          path: path,
          hierarchy_name: hierarchy.name,
          hierarchy_backend: hierarchy.backend,
          value: search_result[:value]
        }
      end
    end.compact
  end

  def write_key(hierarchy_name, path, key, value, facts: {})
    hierarchy = find_hierarchy(hierarchy_name)
    read_file = DataFile.new(path: hierarchy.datadir.join(path), facts: facts)
    read_file.write_key(key, value)
  end

  def remove_key(hierarchy_name, path, key, facts: {})
    hierarchy = find_hierarchy(hierarchy_name)
    read_file = DataFile.new(path: hierarchy.datadir.join(path), facts: facts)
    read_file.remove_key(key)
  end

  def decrypt_value(hierarchy_name, value)
    hierarchy = find_hierarchy(hierarchy_name)
    Hiera::Backend::Eyaml::Options["pkcs7_private_key"] = hierarchy.private_key
    Hiera::Backend::Eyaml::Options["pkcs7_public_key"] = hierarchy.public_key
    parser = Hiera::Backend::Eyaml::Parser::Parser.new([Hiera::Backend::Eyaml::Parser::EncHieraTokenType.new, Hiera::Backend::Eyaml::Parser::EncBlockTokenType.new])
    tokens = parser.parse(value)
    tokens.map(&:to_plain_text).join
  end

  def encrypt_value(hierarchy_name, value)
    hierarchy = find_hierarchy(hierarchy_name)
    Hiera::Backend::Eyaml::Options["pkcs7_private_key"] = hierarchy.private_key
    Hiera::Backend::Eyaml::Options["pkcs7_public_key"] = hierarchy.public_key
    encryptor = Hiera::Backend::Eyaml::Encryptor.find
    ciphertext = encryptor.encode(encryptor.encrypt(value))
    token = Hiera::Backend::Eyaml::Parser::EncToken.new(:block, value, encryptor, ciphertext, nil, '  ')
    token.to_encrypted format: :string
  end

  def lookup_options(facts)
    result = {}
    config.hierarchies.each do |hierarchy|
      hierarchy.resolved_paths(facts: facts).each do |path|
        file = DataFile.new(path: hierarchy.datadir.join(path))
        result = (file["lookup_options"] || {}).merge(result)
      end
    end
    result
  end

  private

  def config
    @config ||= Config.new(Pathname.new(self.class.config_dir)
      .join("environments", environment))
  end

  def find_hierarchy(name)
    config.hierarchies.find { |h| h.name == name }
  end
end
# rubocop:enable Metrics/ClassLength
