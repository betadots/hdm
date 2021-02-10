module Puppet
  module DataLoader
    def self.get_environments
      Dir.glob("#{PUPPET_CONF_DIR}/environments/**/hiera.yaml").sort.map do |file|
        name = file.split('/').last(2).first
        configurations = YAML.load_file(file)
        Struct.new(:name, :configurations).new(name, configurations)
      end
    end

    def self.get_environment(name)
      get_environments.find { |environment| environment.name == name }
    end
  end
end
