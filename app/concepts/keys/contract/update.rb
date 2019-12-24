module Keys::Contract
  class Update < Reform::Form
    include Keys::Representer::OpenStructModule

    validates :path, presence: true
    validates :value, presence: true
    validate :valid_json

    def valid_json
      loaded_json = YAML.load(value)
      errors.add(:value, "specified value for key is not a valid YAML") if loaded_json.nil?
      true
    rescue Psych::SyntaxError => e
      errors.add(:value, "specified value for key is not a valid YAML")
    end
  end
end
