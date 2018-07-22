# frozen_string_literal: true

require 'require_all'

require_rel 'builders'
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

    @downloaders = (options[:downloaders] || []) + DOWNLOADERS
    @parsers = (options[:parsers] || []) + PARSERS
  end

  def convert(source)
    downloader = downloaders.find { |kind| kind.usable?(source) }
    converter = Kernel.const_get("Builder::#{options[:output].capitalize}")

    feed = source_feed(source, downloader, parsers)
    # here - sorting & limiting
    converter.new.render(feed)
  end

  def source_feed(source, downloader, xml_parsers)
    source_data = downloader.new.get(source)

    Parser::Xml.new(xml_parsers).parse(source_data)
  end
end
