class HieraData
  class Lookup
    def initialize(hashes)
      @hashes = hashes
    end

    def lookup(key, merge_strategy: :first)
      applicable_values = extract_key_from_hashes(key)
      merge_values(applicable_values, merge_strategy)
    end

    private

    def extract_key_from_hashes(key)
      @hashes
        .select { |h| h.key?(key) }
        .pluck(key)
    end

    def merge_values(values, strategy)
      case strategy
      when :first
        values.first
      when :unique
        unique_array_merge(values)
      when :hash
        flat_hash_merge(values)
      when :deep
        deep_merge(values)
      end
    end

    def unique_array_merge(values)
      values.inject([]) do |memo, value|
        raise Hdm::Error, "Merge strategy `unique` is not applicable to a hash." if value.is_a?(Hash)

        memo + Array(value)
      end.uniq
    end

    def flat_hash_merge(values)
      values.inject({}) do |memo, value|
        raise Hdm::Error, "Merge strategy `hash` can only be used with hashes." unless value.is_a?(Hash)

        value.merge(memo)
      end
    end

    def deep_merge(values)
      values.inject do |memo, value|
        memo ||= {}

        DeepMerge.deep_merge!(memo, value, merge_hash_arrays: true)
      end
    end
  end
end
