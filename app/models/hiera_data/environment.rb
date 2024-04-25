class HieraData
  class Environment
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def base_path
      @base_path ||=
        Pathname.new(config_dir)
                .join("environments", @name)
    end

    def module_path(module_name:)
      module_paths
        .map { |p| p.join(module_name) }
        .find(&:exist?)
    end

    private

    def module_paths
      full_modulepath_setting = replace_basemodulepath_in(modulepath_from_config)
      full_modulepath_setting.split(":").map do |path|
        pathname = Pathname.new(path)
        pathname = base_path.join(pathname) if pathname.relative?
        pathname
      end
    end

    def modulepath_from_config
      config_file = base_path.join("environment.conf")
      modulepath_config =
        if config_file.exist?
          File.read(config_file)
              .match(/^modulepath\s*=\s*(.+)$/)&.captures&.first
        end
      modulepath_config || "modules:$basemodulepath"
    end

    def replace_basemodulepath_in(string)
      basemodulepath = Rails.configuration.hdm.base_module_path || "#{config_dir}/modules:/opt/puppetlabs/puppet/modules"
      string.gsub("$basemodulepath", basemodulepath)
    end

    def config_dir
      @config_dir ||= Rails.configuration.hdm.config_dir
    end
  end
end
