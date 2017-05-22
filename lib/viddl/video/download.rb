require "tmpdir"

module Viddl

  module Video

    class Download

      # download is stored to temp dir before processing
      DEFAULT_TEMPDIR = Dir.tmpdir
      # download format is forced to mp4 to optimize for quickness
      FORMAT_ARG = "-f 'best[ext=mp4]'"

      # Download the given video
      # @param [Video::Instance] video
      # @param [Hash] options
      # @option options [String] :flags Flags to pass to youtube-dl
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
      # @option options [String] :flags Flags to pass to youtube-dl
      # @return [Boolean]
      def process(options = {})
        cmd = command_line(options)
        result = Kernel.system(cmd)
        raise(result.to_s) unless result
        true
      end

      private

      # Command line to download the video file
      # @param [Hash] options
      # @option options [String] :flags Flags to pass to youtube-dl
      # @return [String]
      def command_line(options = {})
        output = "-o '#{DEFAULT_TEMPDIR}/#{@video.id}s.%(ext)s'"
        "youtube-dl #{@video.source_url} #{FORMAT_ARG} #{options[:flags]} #{output}"
      end

    end

  end

end
