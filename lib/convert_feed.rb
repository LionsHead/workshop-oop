# frozen_string_literal: true

require_relative 'downloader'
require_relative 'parser'
require_relative 'builder'

class ConverterFeed
  def initialize(options)
    @options = options
  end

  def convert
    source_xml = Downloader.download(@options[:source])
    data = Parser.new.parse(source_xml)
    xml = Builder.new.build(data)

    pp xml
  end
end
