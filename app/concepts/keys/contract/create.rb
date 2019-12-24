module Keys::Contract
  class Create < Reform::Form
    include Keys::Representer::OpenStructModule

    validates :id, presence: true

    # def valid_json
    #   loaded_json = YAML.load(value)
    #   errors.add(:value, "specified value for key is not a valid JSON") if loaded_json.nil?
    #   true
    # rescue Psych::SyntaxError => e
    #   errors.add(:value, "specified value for key is not a valid JSON")
    # end
  end
end
