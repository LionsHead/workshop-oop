# frozen_string_literal: true

require_relative 'builder/atom'
require_relative 'builder/rss'

module Builder
  module_function

  def build(data)
    Builder::Rss.build(data)
  end
end
