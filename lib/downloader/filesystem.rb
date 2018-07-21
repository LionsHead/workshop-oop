# frozen_string_literal: true

class Downloader
  class Filesystem
    def download_by(path)
      File.open(path, &:read)
    end
  end
end
