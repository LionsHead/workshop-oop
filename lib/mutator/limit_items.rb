# frozen_string_literal: true

class Mutator
  class LimitItems
    def self.transdorm!(data, options = {})
      limit = options[:limit].to_i
      return data unless limit.positive?

      {
        info: data[:info],
        items: data[:items].first(limit)
      }
    end
  end
end
