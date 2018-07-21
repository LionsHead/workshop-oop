# frozen_string_literal: true

class Downloader
  class Filesystem
    def self.usable?(path)
      path.is_a?(String) && File.exist?(path)
    end

    def download(path)
      File.open(path, &:read)
    end
  end
end
