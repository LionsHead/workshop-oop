# frozen_string_literal: true

require 'uri'

require_relative 'downloader/filesystem'
require_relative 'downloader/http'
require_relative 'downloader/stdin'

module Downloader
  module_function

  def download(args)
    kind = args_kind(args)
    Kernel.const_get("Downloader::#{kind}").new.download_by(args)
  end

  def correct_url?(url)
    url =~ URI::DEFAULT_PARSER.make_regexp
  end

  def args_kind(args)
    if args.nil?
      :Stdin
    elsif correct_url?(args)
      :Http
    elsif File.exist?(args)
      :Filesystem
    end
  end
end
