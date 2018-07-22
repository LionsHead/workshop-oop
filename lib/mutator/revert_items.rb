# frozen_string_literal: true

class Mutator
  class RevertItems
    def self.transdorm!(data, options = {})
      return data unless options[:revert]

      {
        info: data[:info],
        items: data[:items].reverse
      }
    end
  end
end
