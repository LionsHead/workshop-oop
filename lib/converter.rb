# frozen_string_literal: true

require 'require_all'
require_rel 'converter'

class Converter
  def initialize(options)
    @options = options
  end

  def converter(data, output)
    return Converter::Rss.new.converter(data) if output == 'rss'

    Converter::Atom.new.converter(data)
  end
end
