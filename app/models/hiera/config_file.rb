class Hiera
  class ConfigFile
    attr_reader :content, :environments

    def initialize(content)
      @content = content
      initialize_environments
    end

    def version5?
      content["version"] == 5
    end

    def default_yaml_data?
      defaults.has_key?("data_hash") && defaults["data_hash"] == "yaml_data"
    end

    def defaults
      content["defaults"]
    end

    def initialize_environments
      return @environments = [] unless content.has_key?("hierarchy")
      @environments = content['hierarchy'].map do |hierarchy|
        default_data_hash = default_yaml_data? ? 'yaml_data' : nil
        Hierarchy.new(hierarchy: hierarchy, default_data_hash: default_data_hash)
      end
    end
  end
end
