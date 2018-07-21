# frozen_string_literal: true

require 'uri'

require_relative 'downloader/filesystem'
require_relative 'downloader/http'
require_relative 'downloader/stdin'

class Downloader
  def initialize
    @kinds = [
      Downloader::Filesystem.new,
      Downloader::Http.new,
      Downloader::Stdin.new
    ]
  end

  def download(args)
    downloader = @kinds.find { |kind| kind.usable?(args) }
    downloader.download_by(args)
  end
end
