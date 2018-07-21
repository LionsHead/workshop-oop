# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Stdin
    def download_by(_argv)
      STDIN.read
    end
  end
end
