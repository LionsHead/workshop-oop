# frozen_string_literal: true

require 'uri'
require_relative 'downloader/filesystem'
require_relative 'downloader/http'
require_relative 'downloader/stdin'

class Downloader
  def download(args)
    path = args.first

    if correct_url?(path)
      Downloader::Http.new.download_by(path)
    elsif File.exist?(path)
      Downloader::Filesystem.new.download_by(path)
    else
      Downloader::Stdin.new.download_by(args)
    end
  end

  def correct_url?(url)
    url =~ URI::DEFAULT_PARSER.make_regexp
  end
end
