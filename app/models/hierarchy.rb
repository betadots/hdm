class Hierarchy
  attr_reader :name, :environment, :node, :datadir, :backend, :files

  def self.all(node)
    facts = node.facts
    environment = node.environment
    HieraData.new(environment.name).hierarchies.map do |hierarchy|
      new(node: node,
          name: hierarchy.name,
          datadir: hierarchy.datadir,
          backend: hierarchy.backend,
          files: hierarchy.resolved_paths(facts: facts),
          encryptable: hierarchy.encryptable?)
    end
  end

  def self.find(node, name)
    all(node).find { |h| h.name == name }
  end

  def initialize(node:, name:, datadir:, backend:, files:, encryptable: false)
    @node = node
    @environment = node.environment
    @name = name
    @datadir = datadir
    @backend = backend
    @files = files
    @encryptable = encryptable
  end

  def values_for(key)
    @values ||= {}
    @values[key] ||=
      hiera_data.search_key(@datadir, @files, key.name, facts: @node.facts).map do |path, path_data|
        Value.new(hierarchy: self,
                  key: key,
                  path: path,
                  file_present: path_data[:file_present],
                  file_writable: path_data[:file_writable],
                  key_present: path_data[:key_present],
                  replaced_from_git: path_data[:replaced_from_git],
                  value: path_data[:value])
      end
  end

  def encrypt_value(value)
    hiera_data.encrypt_value(name, value)
  end

  def decrypt_value(value)
    hiera_data.decrypt_value(name, value)
  end

  def eyaml?
    backend == :eyaml
  end

  def encryption_possible?
    eyaml? &&
      Rails.configuration.hdm.allow_encryption &&
      @encryptable
  end

  private

  def hiera_data
    @hiera_data ||= HieraData.new(environment.name)
  end
end
