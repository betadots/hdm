class HieraData
  module Interpolation
    VARIABLE_REGEXP = /%{(::)?(facts|trusted)\.([^}]+)}/

    module_function

    def interpolate_globs(path:, datadir:)
      Dir.glob(path, base: datadir).sort
    end

    def interpolate_facts(path:, facts:)
      path.gsub(VARIABLE_REGEXP) do |variable_string|
        _, _, scope, name = variable_string.match(VARIABLE_REGEXP).to_a
        name = "trusted.#{name}" if scope == "trusted"
        value = facts.dig(*name.split("."))
        value || variable_string
      end
    end

    def replace_variables_with_globs(path)
      path.gsub(VARIABLE_REGEXP, "*")
    end
  end
end
