class HieraData
  class Config
    attr_reader :content, :hierarchies

    def initialize(hiera_yaml)
      @hiera_yaml = hiera_yaml
      @base_path = File.dirname(hiera_yaml)
      @content = load_content
      initialize_hierarchies
    end

    private

    def load_content
      defaults = Puppet::Pops::Lookup::HieraConfigV5::DEFAULT_CONFIG_HASH
      config = if File.exist?(@hiera_yaml)
                 parsed_file = YAML.load_file(@hiera_yaml)
                 unless parsed_file["version"] == 5
                   raise Hdm::Error, "hdm needs your hiera.yaml configuration to be in the version 5 format. Please convert your config file(s) before using hdm."
                 end
                 parsed_file
               else
                 {}
               end
      config['defaults'] ||= {}
      defaults.deep_merge(config)
    rescue => error
      raise Hdm::Error, error
    end

    def initialize_hierarchies
      @hierarchies = content['hierarchy'].map do |hierarchy|
        Hierarchy.new(
          raw_hash: content['defaults'].merge(hierarchy),
          base_path: @base_path
        )
      end
    end
  end
end
