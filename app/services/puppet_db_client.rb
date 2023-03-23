module PuppetDbClient
  module ClassMethods
    def nodes(environment: nil)
      query = environment ? [:'=', 'environment', environment] : nil
      response = client.request('inventory', query, {})
      response.data
    rescue
      []
    end

    def facts(certname:)
      response = client.request(
        'facts',
        [:'=', 'certname', certname],
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
      response.data.pluck('name')
    rescue => e
      raise Hdm::Error, e
    end

    def client
      connection_hash = Rails.configuration.hdm.puppet_db

      PuppetDB::Client.new(connection_hash)
    end
  end

  extend ClassMethods
end
