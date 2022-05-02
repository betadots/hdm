class HieraData
  module Interpolation

    module_function

    def interpolate_globs(path:, datadir:)
      Dir.glob(path, base: datadir).sort
    end

    def interpolate_facts(path:, facts:)
      groups = path.scan(/%{([^}]+)}/)
      groups.flatten!
      groups.each { |x| x.gsub!(/^(::|facts\.)/, '')}

      resolved_path = path.dup

      groups.each do |fact|
        facts_value = facts.dig(*fact.split("."))
        next unless facts_value
        resolved_path.gsub!(/%{(::|facts\.)?#{fact}}/, facts_value)
      end

      resolved_path
    end
  end
end
