# frozen_string_literal: true

require 'require_all'

require_rel 'builders'
require_rel 'downloader'
require_rel 'parser'

class ConverterFeed
  attr_accessor :default_options, :downloaders, :parsers

  DOWNLOADERS = [
    Downloader::Filesystem,
    Downloader::Http,
    Downloader::Stdin
  ].freeze

  PARSERS = [
    Parser::Atom,
    Parser::Rss
  ].freeze

  def initialize(options = {})
    @default_options = options

    @downloaders = (options[:downloaders] || []) + DOWNLOADERS
    @parsers = (options[:parsers] || []) + PARSERS
  end

  def convert(source, options = {})
    output = options[:output] || default_options[:output]

    downloader = downloaders.find { |kind| kind.usable?(source) }
    converter = Kernel.const_get("Builder::#{output.capitalize}")

    source_data = downloader.new.get(source)
    feed = parse(source_data, parsers)
    # here - sorting & limiting
    converter.new.render(feed)
  end

  def parse(source_data, xml_parsers)
    parser = Parser::Xml.new(xml_parsers)
    parser.parse(source_data)
  end
end
