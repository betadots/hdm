class Value
  ENCRYPTED_PATTERN = /.*ENC\[.*\]/

  attr_reader :path

  def initialize(path:, file_present:, key_present:, value:)
    @path = path
    @file_present = file_present
    @key_present = key_present
    @value = value
  end

  def file_present?
    @file_present
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

  def value(decrypt: false)
    if decrypt && encrypted?
      @value
    else
      @value
    end
  end
end
