class Value
  ENCRYPTED_PATTERN = /.*ENC\[.*\]/

  attr_reader :path

  def initialize(hierarchy:, key:, path:, file_present:, file_writable:, key_present:, replaced_from_git:, value:)
    @hierarchy = hierarchy
    @key = key
    @path = path
    @file_present = file_present
    @file_writable = file_writable
    @key_present = key_present
    @replaced_from_git = replaced_from_git
    @value = value
  end

  def file_present?
    @file_present
  end

  def file_writable?
    !Rails.configuration.hdm['read_only'] && @file_writable
  end

  def key_present?
    @key_present
  end

  def encrypted?
    file_present? &&
      key_present? &&
      @value.is_a?(String) &&
      @value.match(ENCRYPTED_PATTERN)
  end

  def replaced_from_git?
    @replaced_from_git
  end

  def value(decrypt: false)
    if decrypt && encrypted?
      hiera_data = HieraData.new(@hierarchy.environment.name)
      hiera_data.decrypt_value(@hierarchy.name, @path, @key.name)
    else
      @value
    end
  end
end
