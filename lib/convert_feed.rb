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
    @default_options = {
      output: 'rss'
    }
    default_options.merge options

    @downloaders = (options[:downloader] || []) + DOWNLOADERS
    @parsers = (options[:parser] || []) + PARSERS
  end

  def convert(source, options = {})
    downloader = downloader_factory(source, options).new
    builder = builder_factory(options).new

    source_data = downloader.get(source)
    feed = parse(source_data, parsers)
    # here - sorting & limiting
    builder.formatter(feed)
  end

  def parse(source_data, xml_parsers)
    parser = Parser::Base.new(xml_parsers)
    parser.parse(source_data)
  end

  def downloader_factory(source, options = {})
    kinds = (options[:downloader] || []) + downloaders
    kinds.find { |kind| kind.usable?(source) }
  end

  def builder_factory(options = {})
    output = options[:output] || default_options[:output]
    Kernel.const_get("Builder::#{output.capitalize}")
  end
end
