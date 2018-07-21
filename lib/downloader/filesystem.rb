# frozen_string_literal: true

module Downloader
  module Filesystem
    module_function

    def download_by(path)
      File.open(path, &:read)
    end
  end
end
