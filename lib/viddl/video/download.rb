require "tmpdir"

module Viddl

  module Video

    class Download

      # download is stored to temp dir before processing
      TEMPDIR = Dir.tmpdir
      # download format is forced to mp4 to optimize for quickness
      FORMAT_ARG = "-f 'best[ext=mp4]'"

      # Download the given video
      # @param [Video::Instance] video
      # @param [Hash] options
      # @return [Download]
      def self.process(video, options = {}, &block)
        download = new(video)
        download.process(options, &block)
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
      def process(options = {}, &block)
        Open3.popen2(command_line) do |y_stdin, y_stdout|
          yield(y_stdout)
        end
      end

      private

      # Command line to download the video file
      # @return [String]
      def command_line
        "youtube-dl #{@video.source_url} #{FORMAT_ARG} -o -"
      end

    end

  end

end
