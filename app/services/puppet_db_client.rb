if Settings.puppet_db.self_signed_cert
  require 'puppetdb/client'

  module PuppetDB
    class FixSSLConnectionAdapter < HTTParty::ConnectionAdapter
      def attach_ssl_certificates(http, options)
        if options[:pem].empty?
          http.ca_file = options[:cacert]
        else
          http.cert    = OpenSSL::X509::Certificate.new(File.read(options[:pem]['cert']))
          http.key     = OpenSSL::PKey::RSA.new(File.read(options[:pem]['key']))
          http.ca_file = options[:pem]['ca_file']
        end
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end
  end
end

module PuppetDBClient
  module ClassMethods
    def nodes
      response = client.request(
        'nodes',
        nil,
        {}
      )
      response.data.map { |x| x.dig("certname") }
    rescue StandardError => e
      []
    end

    def facts(certname:, environment:)
      response = client.request(
        'facts',
        [:and,
          [:'=', 'certname', certname],
          [:'=', 'environment', environment]
        ],
        {}
      )

      facts = {}
      response.data.each { |item| facts[item["name"]] = item["value"] }
      facts
    end

    def environments
      response = client.request(
        'environments',
        nil,
        {}
      )
      response.data.map { |x| x["name"] }
    rescue => e
      raise Hdm::Error, e
    end

    def client
      connection_hash = {
        server: Settings.puppet_db.server
      }

      connection_hash[:cacert] = Settings.puppet_db.ca_cert if Settings.puppet_db.ca_cert
      connection_hash[:token] = Settings.puppet_db.token if Settings.puppet_db.token

      PuppetDB::Client.new(connection_hash)
    end
  end

  extend ClassMethods
end
