# frozen_string_literal: true

require 'require_all'

require_rel 'converter'
require_rel 'downloader'
require_rel 'parser'

class ConverterFeed
  def initialize(options)
    @options = options
  end

  def convert
    source = @options[:source]
    # output = @options[:output] - need  more converter

    kinds = [
      Downloader::Filesystem.new(source),
      Downloader::Http.new(source),
      Downloader::Stdin.new(source)
    ]

    downloader = kinds.find(&:usable?)
    parser = Parser::Atom.new
    builder = Converter::Rss.new # options[:output]

    xml = converter(downloader, parser, builder)

    STDOUT.puts xml if @options[:output]

    xml
  end

  def converter(downloader, parser, builder)
    source_xml = downloader.download
    data = parser.parse(source_xml)

    builder.render(data)
  end
end
