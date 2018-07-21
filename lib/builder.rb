# frozen_string_literal: true

require_relative 'builder/atom'
require_relative 'builder/rss'

class Builder
  def initialize(options)
    @options = options
  end

  def build(data)
    Builder::Rss.new.build(data)
  end
end
