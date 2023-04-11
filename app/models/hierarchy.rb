class Hierarchy < HieraModel
  attribute :name, :string
  attribute :environment
  attribute :backend
  attribute :encryptable, :boolean, default: false

  def self.all(environment)
    HieraData.new(environment.name).hierarchies.map do |hierarchy|
      new(name: hierarchy.name,
          environment:,
          backend: hierarchy.backend,
          encryptable: hierarchy.encryptable?)
    end
  end

  def self.find(environment, name)
    all(environment).find { |h| h.name == name }
  end

  def files_for(node:)
    hiera_data.files_for(name, facts: node.facts).map do |data_file|
      DataFile.new(hierarchy: self, path: data_file, node:)
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
      encryptable
  end

  def to_param
    name
  end
end
