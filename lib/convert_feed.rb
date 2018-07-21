# frozen_string_literal: true

require 'require_all'

require_rel 'converter'
require_rel 'downloader'
require_rel 'parser'

class ConverterFeed
  attr_accessor :options, :downloaders, :parsers

  DOWNLOADERS = [
    Downloader::Filesystem,
    Downloader::Http,
    Downloader::Stdin
  ]

  PARSERS = [
    Parser::Atom,
    Parser::Rss
  ]

  def initialize(options)
    @options = options

    @downloaders = DOWNLOADERS
    downloaders.concat options[:downloaders] if options[:downloaders]

    @parsers = PARSERS
    parsers.concat options[:parsers] if options[:parsers]
  end

  def convert
    source = options[:source]
    output = options[:output]

    downloader = downloaders.find { |kind| kind.usable?(source) }
    # TODO: parser = Parser::Xml.new(parsers)
    parser = Parser::Rss
    feed = source_feed(downloader, parser, source: source)

    # here - sorting & limiting by options?

    converter = Kernel.const_get("Converter::#{output.capitalize}")
    xml = converter.new.render(feed)

    STDOUT.puts xml if output

    xml
  end

  def source_feed(downloader, parser, options)
    source_data = downloader.new.get(options[:source])

    parser.new.parse(source_data)
  end
end
