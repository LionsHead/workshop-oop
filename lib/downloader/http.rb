# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Http 
    def download_by(path)
      open(path, &:read)
    end
  end
end
