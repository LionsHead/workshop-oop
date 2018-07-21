# frozen_string_literal: true

require 'open-uri'

module Downloader
  module Stdin
    module_function

    def download_by(stdin)
      stdin.join(' ')
    end
  end
end
