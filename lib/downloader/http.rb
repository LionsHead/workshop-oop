# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Http
    def self.usable?(url)
      url.is_a?(String) && url =~ URI::DEFAULT_PARSER.make_regexp
    end

    def get(url)
      open(url, &:read)
    end
  end
end
