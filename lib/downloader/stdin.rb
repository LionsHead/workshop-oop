# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Stdin
    def usable?(_args)
      true
    end

    def download_by(_argv)
      STDIN.read
    end
  end
end
