module Viddl

  module System

    extend self

    def validate
      validate_youtube_dl
      validate_ffmpeg
    end

    private

    def validate_ffmpeg
      result = system("ffmpeg")
      if result.nil?
        raise("Viddl requires that ffmpeg be installed")
      end
    end

    def validate_youtube_dl
      result = system("youtube-dl")
      if result.nil?
        raise("Viddl requires that youtube-dl be installed https://github.com/rg3/youtube-dl")
      end
    end

  end

end
