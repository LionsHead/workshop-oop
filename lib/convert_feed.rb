# frozen_string_literal: true

require 'require_all'

require_rel 'converter'
require_rel 'downloader'
require_rel 'parser'

class ConverterFeed
  attr_reader :options

  def initialize(options)
    @options = options
  end

  def convert
    source = options[:source]
    # output = @options[:output] - need  more converter

    kinds = [
      Downloader::Filesystem,
      Downloader::Http,
      Downloader::Stdin
    ]

    downloader = kinds.find { |kind| kind.usable?(source) }
    parser = Parser::Atom.new
    builder = Converter::Rss.new # options[:output]

    xml = converter(downloader, parser, builder)

    STDOUT.puts xml if options[:output]

    xml
  end

  def converter(downloader, parser, builder)
    source_xml = downloader.download
    data = parser.parse(source_xml)

    builder.render(data)
  end
end
