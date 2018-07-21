# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Stdin
    def self.usable?(_source)
      true
    end

    def download(_source)
      STDIN.read
    end
  end
end
