# frozen_string_literal: true

require 'require_all'
require 'uri'
require_rel 'downloader'

class Downloader
  def initialize(_kind = nil)
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
