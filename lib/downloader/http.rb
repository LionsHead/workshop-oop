# frozen_string_literal: true

require 'open-uri'

module Downloader
  module Http
    module_function

    def download_by(path)
      open(path, &:read)
    end
  end
end
