class HieraData
  class Hierarchy
    attr_reader :hierarchy, :default_data_hash

    def initialize(hierarchy:, default_data_hash:)
      @hierarchy = hierarchy
      @default_data_hash = default_data_hash
    end

    def name
      hierarchy.fetch("name", "Unnamed")
    end

    def yaml?
      return true if default_data_hash == "yaml_data" && !other_backend_specified?
      return true if hierarchy["data_hash"] == "yaml_data"
      false
    end

    def other_backend_specified?
      return true if hierarchy.has_key?("lookup_key")
      return true if hierarchy.has_key?("data_dig")
      return true if hierarchy.has_key?("hiera3_backend")
      false
    end

    def paths
      return [] unless hierarchy.has_key?("paths")
      hierarchy["paths"]
    end

    def expected_facts
      expected_facts = []
      paths.each do |path|
        groups = path.scan(/%{([^}]+)}/)
        groups.each do |matches|
          matches.each { |match| expected_facts << match }
        end
      end
      expected_facts.sort.uniq
    end
  end
end
