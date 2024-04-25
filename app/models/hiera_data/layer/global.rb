class HieraData
  module Layer
    class Global < Base
      def base_path
        hiera_yaml.dirname
      end

      def name = "global"

      def description = nil

      private

      def hiera_yaml
        Pathname.new(
          Rails.configuration.hdm.global_hiera_yaml || "/etc/puppetlabs/puppet/hiera.yaml"
        )
      end
    end
  end
end
