# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Http
    def initialize(source)
      @source = source
    end

    def usable?
      @source =~ URI::DEFAULT_PARSER.make_regexp
    end

    def download
      open(@source, &:read)
    end
  end
end
