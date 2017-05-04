module Viddl

  module System

    extend self

    # Validate that the system has all of its dependencies
    # @return [Boolean]
    def validate
      validate_ffmpeg
      validate_youtube_dl
      true
    end

    private

    # Validate that ffmpeg is installed
    # @return [Boolean]
    def validate_ffmpeg
      result = Kernel.system("ffmpeg")
      if result.nil?
        raise("Viddl requires that ffmpeg be installed")
      end
      true
    end

    # Validate that youtube-dl is installed
    # @return [Boolean]
    def validate_youtube_dl
      result = Kernel.system("youtube-dl")
      if result.nil?
        raise("Viddl requires that youtube-dl be installed https://github.com/rg3/youtube-dl")
      end
    end

  end

end
