class Value < HieraModel
  attribute :data_file
  attribute :key
  attribute :value, :string

  delegate :hierarchy, to: :data_file
  delegate :environment, to: :hierarchy

  def encrypted?
    HieraData::EYamlFile.encrypted?(value)
  end

  def update(new_value, node: nil)
    parsed_value = YAML.safe_load(new_value)
    facts = node ? node.facts : {}
    hiera_data.write_key(data_file.hierarchy.name, data_file.path, key.name, parsed_value, facts:)
  end

  def destroy(node: nil)
    facts = node ? node.facts : {}
    hiera_data.remove_key(data_file.hierarchy.name, data_file.path, key.name, facts:)
  end
end
