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

    @downloaders = (options[:downloaders] || []) + DOWNLOADERS
    @parsers = (options[:parsers] || []) + PARSERS
  end

  def convert
    downloader = downloaders.find { |kind| kind.usable?(options[:source]) }
    converter = Kernel.const_get("Converter::#{options[:output].capitalize}")

    feed = source_feed(options[:source], downloader)
    # here - sorting & limiting
    converter.new.render(feed)
  end

  def source_feed(source, downloader)
    source_data = downloader.new.get(source)

    Parser::Xml.new(parsers).parse(source_data)
  end
end
