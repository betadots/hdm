class HieraData
  class ConfigFile
    attr_reader :content, :hierarchies

    def initialize(base_path)
      @content = load_content(base_path)
      initialize_hierarchies
    end

    def version5?
      content["version"] == 5
    end

    def default_yaml_data?
      defaults && defaults.has_key?("data_hash") && defaults["data_hash"] == "yaml_data"
    end

    def defaults
      content["defaults"]
    end

    private

    def load_content(base_path)
      full_path = base_path.join("hiera.yaml")
      defaults = Puppet::Pops::Lookup::HieraConfigV5::DEFAULT_CONFIG_HASH
      config = if File.exist?(full_path)
                 parsed_file = YAML.load(File.read(full_path))
                 unless parsed_file["version"] == 5
                   raise Hdm::Error, "hdm needs your hiera.yaml configuration to be in the version 5 format. Please convert your config file(s) before using hdm."
                 end
                 parsed_file
               else
                 {}
               end
      defaults.merge(config)
    rescue => error
      raise Hdm::Error, error
    end

    def initialize_hierarchies
      return @hierarchies = [] unless content.has_key?("hierarchy")
      @hierarchies = content['hierarchy'].map do |hierarchy|
        default_data_hash = default_yaml_data? ? 'yaml_data' : nil
        Hierarchy.new(hierarchy: hierarchy, default_data_hash: default_data_hash)
      end
    end
  end
end
