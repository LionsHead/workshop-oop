# frozen_string_literal: true

require_relative 'downloader'
require_relative 'parser'
require_relative 'converter'

class ConverterFeed
  def convert(options)
    source = options[:source]
    output = options[:output]

    source_xml = Downloader.new.download(source)
    data = Parser.new.parse(source_xml)

    converter = Converter.new(options)
    xml = converter.converter(data, output)

    STDOUT.puts xml
  end
end
