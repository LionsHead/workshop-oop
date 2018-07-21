# frozen_string_literal: true

require_relative 'converter/atom'
require_relative 'converter/rss'

class Converter
  def initialize(options)
    @options = options
  end

  def converter(data, output)
    return Converter::Rss.new.converter(data) if output == 'rss'

    Converter::Atom.new.converter(data)
  end
end
