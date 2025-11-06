class Hierarchy < HieraModel
  attribute :name, :string
  attribute :layer
  attribute :backend
  attribute :encryptable, :boolean, default: false
  attribute :hiera_hierarchy

  delegate :environment, to: :layer

  def self.all(layer:)
    layer.hiera_layer.hierarchies.map do |hierarchy|
      new(name: hierarchy.name,
          layer:,
          backend: hierarchy.backend,
          encryptable: hierarchy.encryptable?,
          hiera_hierarchy: hierarchy)
    end
  end

  def self.find(layer:, name:)
    all(layer:).find { |h| h.name == name }
  end

  def ==(other)
    other.is_a?(Hierarchy) &&
      layer == other.layer &&
      name == other.name
  end

  def file(path:, node: nil)
    hiera_file = hiera_hierarchy.file(path:, facts: node&.facts)
    DataFile.new(hierarchy: self, path:, hiera_file:)
  end

  def files_for(node:)
    hiera_hierarchy.resolved_paths(facts: node.facts).map do |path|
      file(path:, node:)
    end
  end

  def candidate_files
    hiera_hierarchy.candidate_files.map do |path|
      relative_path = path
                      .sub(hiera_hierarchy.datadir.to_s, "")
                      .delete_prefix("/")
      DataFile.new(hierarchy: self, path: relative_path)
    end
  end

  def values_for(key:)
    hiera_hierarchy.files_and_values_for(key: key.name).map do |file, value|
      Value.new(
        key:,
        value:,
        data_file: DataFile.new(path: file.path, hierarchy: self, hiera_file: file)
      )
    end
  end

  def encrypt_value(value)
    hiera_hierarchy.encrypt_value(value:)
  end

  def decrypt_value(value)
    hiera_hierarchy.decrypt_value(value:)
  end

  def eyaml?
    backend == :eyaml
  end

  def encryption_possible?
    eyaml? &&
      Rails.configuration.hdm.allow_encryption &&
      encryptable
  end

  def to_param
    name
  end
end
