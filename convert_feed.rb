# frozen_string_literal: true

require 'optparse'
require_relative 'lib/convert_feed'

options = {}
opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: convert-feed.rb [OPTIONS] [FILE]'

  opts.on('--out FORMAT', 'Output feed format: atom, rss ') do |type|
    options[:out] = type.downcase
  end
end
opt_parser.parse!

options[:source] = ARGV

ConverterFeed.new(options).run
