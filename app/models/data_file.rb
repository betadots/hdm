class DataFile < HieraModel
  attribute :hierarchy
  attribute :path, :string
  attribute :exist, :boolean, default: false
  attribute :writable, :boolean, default: false
  attribute :replaced_from_git, :boolean, default: false
  attribute :hiera_file

  delegate :environment, to: :hierarchy

  def initialize(attributes = {})
    super
    return unless hiera_file

    self.exist = hiera_file.exist?
    self.writable = hiera_file.writable?
    self.replaced_from_git = hiera_file.replaced_from_git?
  end

  def ==(other)
    other.is_a?(DataFile) &&
      hierarchy == other.hierarchy &&
      path == other.path
  end

  def keys
    @keys ||= hiera_file.keys.map do |key_name|
      Key.new(name: key_name)
    end
  end

  def has_key?(key:)
    keys.include?(key)
  end

  def value_for(key:)
    raw_value = (hiera_file.content_for_key(key.name) if has_key?(key:)) # rubocop:disable Style/PreferredHashMethods
    Value.new(data_file: self, key:, value: raw_value)
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

  def id
    path.parameterize
  end

  def has_differing_value_in_original_environment?(node:, key:)
    return false unless environment && node.environment
    return false if environment == node.environment

    candidate_files = node.environment.environment_layer.hierarchies.map do |h|
      h.file(path:, node:)
    end
    other_file = candidate_files.find(&:exist?)
    return false unless other_file

    return false if value_for(key:).value == other_file.value_for(key:).value

    true
  end

  def value_from_original_environment(node:, key:)
    candidate_files = (node&.environment&.environment_layer&.hierarchies || []).map do |h|
      h.file(path:, node:)
    end
    other_file = candidate_files.find(&:exist?)
    other_file.value_for(key:)
  end
end
