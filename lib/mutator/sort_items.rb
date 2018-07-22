# frozen_string_literal: true

class Mutator
  class SortItems
    def self.transdorm!(data, options = {})
      return data unless options[:sort]

      sort_by = ->(item) { Time.parse(item[:date]).to_i }

      sorted_items = data[:items].sort do |a, b|
        sort_by.call(a) <=> sort_by.call(b)
      end

      {
        info: data[:info],
        items: sorted_items
      }
    end
  end
end
