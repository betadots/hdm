module PuppetDbClient
  module ClassMethods
    def nodes
      response = client.request(
        'nodes',
        nil,
        {}
      )
      response.data.map { |x| x.dig("certname") }
    rescue
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
      connection_hash = Rails.configuration.hdm["puppet_db"].with_indifferent_access

      PuppetDB::Client.new(connection_hash)
    end
  end

  extend ClassMethods
end
