#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative '../lib/convert_feed'

options = {}
opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: convert-feed.rb [OPTIONS] [FILE]'

  opts.on('--out FORMAT', 'Output feed format: atom, rss ') do |type|
    options[:output] = type.downcase
  end
end
opt_parser.parse!

options[:source] = ARGV.length > 1 ? ARGV : ARGV.first

ConverterFeed.new.convert(options)