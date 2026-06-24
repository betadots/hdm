class Environment < HieraModel
  attribute :name, :string
  attribute :in_use, :boolean, default: false
  attribute :available, :boolean, default: false

  def self.all
    environments_in_use = PuppetDbClient.environments
    available_environments = HieraData.environments(
      config_dir: Rails.configuration.hdm.config_dir
    )
    display_unused_environments = Rails.configuration.hdm.display_unused_environments
    exclude_environments = Rails.configuration.hdm.exclude_environments
    all_environments = {}
    environments_in_use.sort.each do |e|
      all_environments[e] = { name: e, in_use: true }
    end
    available_environments.sort.each do |e|
      all_environments[e] ||= { name: e }
      all_environments[e][:available] = !excluded?(e, exclude_environments)
    end
    if display_unused_environments
      all_environments.map { |_, attributes| new(**attributes) }
    else
      all_environments.select { |_, attributes| attributes[:in_use] }.map { |_, attributes| new(**attributes) }
    end
  end

  def self.excluded?(environment_name, exclude_list)
    exclude_list.any? do |pattern|
      if pattern.is_a?(Regexp)
        pattern.match?(environment_name)
      else
        pattern == environment_name
      end
    end
  end

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
