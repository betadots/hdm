class HieraData
  class EnvironmentNotFound < StandardError; end

  attr_reader :environment, :layers

  def self.environments(config_dir:)
    Pathname.new(config_dir)
            .join("environments")
            .glob("*/")
            .map { |p| p.basename.to_s }
  end

  def initialize(environment:)
    @environment = environment
    @layers = HieraData::Layer.for(environment:)
  end

  def find_layer(layer_name:)
    @layers.find { |l| l.name == layer_name }
  end

  def find_hierarchy(layer_name:, hierarchy_name:)
    find_layer(layer_name:).find_hierarchy(hierarchy_name:)
  end

  def all_keys(facts:)
    @layers.flat_map { |l| l.all_keys(facts:) }
           .sort.uniq
  end

  def lookup_options_for(key:, facts: {}, decrypt: false)
    candidates = lookup_for(facts:, decrypt:)
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
    lookup_for(facts:).lookup(key, merge_strategy:)
  end

  private

  def lookup_for(facts:, decrypt: false)
    @cached_lookups ||= {}
    @cached_lookups[facts] ||= begin
      hashes = @layers.flat_map { |l| l.file_contents(facts:, decrypt:) }
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
