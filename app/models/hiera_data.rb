class HieraData
  class EnvironmentNotFound < StandardError; end

  attr_reader :environment
  delegate :hierarchies, to: :config

  def initialize(environment)
    @environment = environment

    raise EnvironmentNotFound.new("Environment '#{environment}' does not exist") unless PuppetDbClient.environments.include?(environment)
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

  def search_key(datadir, files, key, facts: {})
    search_results = {}
    files.each do |path|
      file = DataFile.new(path: datadir.join(path), facts: facts)
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

  def config_dir
    @config_dir ||= Rails.configuration.hdm.config_dir
  end

  def config
    @config ||= Config.new(Pathname.new(config_dir).join("environments", environment))
  end

  def find_hierarchy(name)
    config.hierarchies.find { |h| h.name == name }
  end
end
