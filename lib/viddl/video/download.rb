module Viddl

  module Video

    class Download

      TEMPDIR = "/tmp"

      # Download the given video
      # @param [Video::Instance] video
      # @param [Hash] options
      # @return [Download]
      def self.process(video, options = {})
        download = new(video)
        download.process(options)
        download
      end

      # @param [Video::Instance] video
      def initialize(video)
        @video = video
      end

      # Download the video file
      # @param [Hash] options
      # @return [Boolean]
      def process(options = {})
        result = Kernel.system(command_line)
        raise(result.to_s) unless result
        true
      end

      private

      # Command line to download the video file
      # @return [String]
      def command_line
        "youtube-dl #{@video.source_url} -o '#{TEMPDIR}/#{@video.id}s.%(ext)s'"
      end

    end

  end

end
