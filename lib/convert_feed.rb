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
  ].freeze

  PARSERS = [
    Parser::Atom,
    Parser::Rss
  ].freeze

  def initialize(options)
    @options = options

    @downloaders = DOWNLOADERS + (options[:downloaders] || [])
    @parsers = PARSERS + (options[:parsers] || [])
  end

  def convert
    downloader = downloaders.find { |kind| kind.usable?(options[:source]) }
    parser = Parser::Rss # TODO: use new parser = Parser::Xml.new(parsers)
    converter = Kernel.const_get("Converter::#{options[:output].capitalize}")

    feed = source_feed(options[:source], downloader, parser)
    # here - sorting & limiting
    converter.new.render(feed)
  end

  def source_feed(source, downloader, parser)
    source_data = downloader.new.get(source)

    parser.new.parse(source_data)
  end
end
