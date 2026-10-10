class Environment < HieraModel
  attribute :name, :string
  attribute :in_use, :boolean, default: false
  attribute :available, :boolean, default: false

  def self.all
    environments = environment_attributes
    environments.select! { |attributes| attributes[:in_use] } unless display_unused_environments?
    environments.map { |attributes| new(**attributes) }
  end

  def self.environment_attributes
    environments = PuppetDbClient.environments.sort.index_with do |name|
      { name:, in_use: true }
    end

    available_environment_names.each do |name|
      environments[name] ||= { name: }
      environments[name][:available] = !excluded?(name)
    end

    environments.values
  end
  private_class_method :environment_attributes

  def self.available_environment_names
    HieraData.environments(config_dir: Rails.configuration.hdm.config_dir).sort
  end
  private_class_method :available_environment_names

  def self.display_unused_environments?
    Rails.configuration.hdm.display_unused_environments
  end
  private_class_method :display_unused_environments?

  def self.excluded?(environment_name)
    Rails.configuration.hdm.exclude_environments.any? do |pattern|
      if pattern.is_a?(Regexp)
        pattern.match?(environment_name)
      else
        pattern == environment_name
      end
    end
  end
  private_class_method :excluded?

  def self.find(name)
    all.find { |e| e.name == name }
  end

  def layers(key: nil)
    Layer.all(environment: self, key:)
  end

  def find_layer(name:)
    layers.find { |l| l.name == name }
  end

  def environment_layer
    @environment_layer ||= find_layer(name: "environment")
  end

  def in_use?
    in_use
  end

  def available?
    available
  end

  def ==(other)
    other.is_a?(Environment) && name == other.name
  end

  def to_param
    name
  end

  def to_s
    name
  end

  def hiera_data
    @hiera_data ||= HieraData.new(environment: name)
  end
end
