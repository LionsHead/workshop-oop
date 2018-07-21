# frozen_string_literal: true

require_relative 'downloader'
require_relative 'parser'
require_relative 'builder'

class ConverterFeed
  def initialize(options)
    @options = options
  end

  def run
    source_xml = Downloader.download(@options[:source])
    data = Parser.parse(source_xml)
    xml = Builder.build(data)

    output(xml)
  end

  def output(xml)
    pp xml
  end
end
