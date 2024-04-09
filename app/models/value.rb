class Value < HieraModel
  attribute :data_file
  attribute :key
  attribute :value, :string

  delegate :hiera_file, to: :data_file

  def encrypted?
    HieraData::EYamlFile.encrypted?(value)
  end

  def update(new_value)
    parsed_value = YAML.safe_load(new_value)
    hiera_file.write_key(key.name, parsed_value)
  end

  def destroy
    hiera_file.remove_key(data_file.path, key.name)
  end
end
