# frozen_string_literal: true

class Downloader
  class Filesystem
    def initialize(source)
      @source = source
    end

    def usable?
      @source.is_a?(String) && File.exist?(@source)
    end

    def download
      File.open(@source, &:read)
    end
  end
end
