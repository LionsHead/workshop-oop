# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Stdin
    def download_by(stdin)
      stdin.join(' ')
    end
  end
end
