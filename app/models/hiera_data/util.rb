class HieraData
  module Util
    module_function

    def yaml_format(value)
      value.to_yaml.sub(/\A---(\n| )/, '').chomp
    end
  end
end
