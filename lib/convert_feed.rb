# frozen_string_literal: true

require 'require_all'

require_rel 'builders'
require_rel 'downloader'
require_rel 'parser'
require_rel 'mutator'

class ConverterFeed
  attr_accessor :default_options, :downloaders, :parsers, :mutators

  DOWNLOADERS = [
    Downloader::Filesystem,
    Downloader::Http,
    Downloader::Stdin
  ].freeze

  PARSERS = [
    Parser::Atom,
    Parser::Rss
  ].freeze

  MUTATORS = [
    Mutator::SortItems,
    Mutator::LimitItems,
    Mutator::RevertItems,
  ].freeze


  def initialize(options = {})
    @default_options = {
      output: 'rss'
    }
    default_options.merge options

    @downloaders = (options[:downloader] || []) + DOWNLOADERS
    @parsers = (options[:parser] || []) + PARSERS
    @mutators = options[:transformsers] || MUTATORS
  end

  def convert(source, options = {})
    downloader = downloader_factory(source, options).new
    builder = builder_factory(options).new

    source_data = downloader.get(source)
    data = parse(source_data, parsers)
    feed = transdorm!(data, options)

    builder.formatter(feed)
  end

  def parse(source_data, xml_parsers)
    parser = Parser::Base.new(xml_parsers)
    parser.parse(source_data)
  end

  def transdorm!(data, opts = {})
    items = opts[:transformsers] || mutators
    items.inject(data) do |feed, mutator|
      mutator.transdorm!(feed, opts)
    end
  end

  def downloader_factory(source, opts = {})
    kinds = (opts[:downloader] || []) + downloaders
    kinds.find { |kind| kind.usable?(source) }
  end

  def builder_factory(opts = {})
    output = opts[:output] || default_options[:output]
    Kernel.const_get("Builder::#{output.capitalize}")
  end
end
