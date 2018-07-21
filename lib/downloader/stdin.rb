# frozen_string_literal: true

require 'open-uri'

class Downloader
  class Stdin
    def self.usable?(_source)
      !STDIN.tty?
    end

    def get(_source)
      STDIN.read
    end
  end
end
