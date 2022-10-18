class DataFile < HieraModel
  attribute :hierarchy
  attribute :node
  attribute :path, :string
  attribute :exist, :boolean, default: false
  attribute :writable, :boolean, default: false
  attribute :replaced_from_git, :boolean, default: false

  delegate :environment, to: :hierarchy

  def self.search(environment, key)
    hierarchies = {}
    result = {}
    HieraData.new(environment.name).files_including(key.name).each do |file|
      hierarchies[file[:hierarchy_name]] ||= Hierarchy.new(
        environment: environment,
        name: file[:hierarchy_name],
        backend: file[:hierarchy_backend]
      )
      data_file = new(
        hierarchy: hierarchies[file[:hierarchy_name]],
        path: file[:path]
      )
      value = Value.new(data_file: data_file, key: key, value: file[:value])
      result[hierarchies[file[:hierarchy_name]]] ||= {}
      result[hierarchies[file[:hierarchy_name]]][data_file] = value
    end
    result
  end

  def initialize(attributes = {})
    super(attributes)
    file_attributes = hiera_data.file_attributes(hierarchy.name, path, facts: node&.facts)
    self.exist = file_attributes[:exist]
    self.writable = file_attributes[:writable]
    self.replaced_from_git = file_attributes[:replaced_from_git]
  end

  def keys
    @keys ||= hiera_data.keys_in_file(hierarchy.name, path).map do |key_name|
      Key.new(environment: environment, name: key_name)
    end
  end

  def has_key?(key)
    keys.include?(key)
  end

  def value_for(key:)
    raw_value = (hiera_data.value_in_file(hierarchy.name, path, key.name, facts: node&.facts) if has_key?(key)) # rubocop:disable Style/PreferredHashMethods
    Value.new(data_file: self, key: key, value: raw_value)
  end

  def writable?
    !Rails.configuration.hdm.read_only && attributes["writable"]
  end

  def exist?
    exist
  end

  def replaced_from_git?
    replaced_from_git
  end

  def to_param
    path
  end
end
