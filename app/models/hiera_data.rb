class HieraData
  attr_reader :environment

  def self.environments(config_dir:)
    Pathname.new(config_dir)
            .join("environments")
            .glob("*/")
            .map { |p| p.basename.to_s }
  end

  def initialize(environment:)
    @environment = environment
  end

  def layers(key: nil)
    HieraData::Layer.for(environment:, key:)
  end

  def all_keys(facts:)
    layers.flat_map { |l| l.all_keys(facts:) }
          .sort.uniq
  end

  def lookup_options_for(key:, facts: {}, decrypt: false)
    candidates = lookup_for(key:, facts:, decrypt:)
                 .lookup("lookup_options", merge_strategy: :hash)
    merge = extract_merge_value(key, candidates)
    case merge
    when String
      merge
    when Hash
      merge["strategy"]
    else
      "first"
    end
  end

  def lookup(key:, facts: {}, decrypt: false)
    merge_strategy = lookup_options_for(key:, facts:, decrypt:).to_sym
    lookup_for(key:, facts:).lookup(key, merge_strategy:)
  end

  private

  def lookup_for(key:, facts:, decrypt: false)
    @cached_lookups ||= {}
    @cached_lookups[facts] ||= {}
    @cached_lookups[facts][key] ||= begin
      hashes = layers(key:).flat_map { |l| l.file_contents(facts:, decrypt:) }
      Lookup.new(hashes.compact)
    end
  end

  def extract_merge_value(key, candidates)
    result = candidates&.dig(key)
    result ||= candidates&.select { |k, _v| k[0] == "^" }
                         &.find { |k, _v| key.match(Regexp.new(k)) }
                         &.last
    result&.dig("merge")
  end
end
