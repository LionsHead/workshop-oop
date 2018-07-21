# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Stdin
    def initialize(_source); end

    def usable?
      true
    end

    def download
      STDIN.read
    end
  end
end
