class HieraData
  module Layer
    def self.for(environment:, key: nil)
      [Global.new, Environment.new(environment:), Module.new(environment:, key:)].compact_blank
    end
  end
end
