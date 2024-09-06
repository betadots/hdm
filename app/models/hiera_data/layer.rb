class HieraData
  module Layer
    def self.for(environment:, key: nil)
      # rubocop:disable Rails/CompactBlank
      [Global.new, Environment.new(environment:), Module.new(environment:, key:)].select(&:present?)
      # rubocop:enable Rails/CompactBlank
    end
  end
end
