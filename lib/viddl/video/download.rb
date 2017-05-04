module Viddl

  module Video

    class Download

      # download is stored to /tmp before processing
      TEMPDIR = "/tmp"
      # download format is forced to mp4 to optimize for quickness
      FORMAT_ARG = "-f 'best[ext=mp4]'"

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
        @video.download = self if @video.download.nil?
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
        "youtube-dl #{@video.source_url} #{FORMAT_ARG} -o '#{TEMPDIR}/#{@video.id}s.%(ext)s'"
      end

    end

  end

end
