# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Http
    def usable?(args)
      correct_url?(args)
    end

    def download_by(path)
      open(path, &:read)
    end

    def correct_url?(url)
      url =~ URI::DEFAULT_PARSER.make_regexp
    end
  end
end
