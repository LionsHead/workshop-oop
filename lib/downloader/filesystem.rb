# frozen_string_literal: true

class Downloader
  class Filesystem
    def usable?(args)
      args.is_a?(String) && File.exist?(args)
    end

    def download_by(path)
      File.open(path, &:read)
    end
  end
end
