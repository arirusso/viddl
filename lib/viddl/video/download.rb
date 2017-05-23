require "tmpdir"

module Viddl

  module Video

    class Download

      # download is stored to temp dir before processing
      DEFAULT_TEMPDIR = Dir.tmpdir
      # download format is forced to mp4 to optimize for quickness
      FORMAT_ARG = "-f 'best[ext=mp4]'"

      attr_reader :paths

      # Download the given video
      # @param [Video::Instance] video
      # @param [Hash] options
      # @option options [String, File] :download_path Path where download should be stored (default: system temp directory)
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
      # @option options [String, File] :download_path Path where download should be stored (default: system temp directory)
      # @option options [String] :flags Flags to pass to youtube-dl
      # @return [Boolean]
      def process(options = {})
        cmd = command_line(options)
        result = Kernel.system(cmd)
        if result
          @paths = Dir["#{path}*"]
        else
          raise(result.to_s)
        end
        true
      end

      private

      # The path where the download should be written
      # @param [Hash] options
      # @option options [String, File] :download_path Path where download should be stored (default: system temp directory)
      # @return [String]
      def path(options = {})
        @download_path ||= build_path(options)
      end

      # Build the download path
      # @param [Hash] options
      # @option options [String, File] :download_path Path where download should be stored (default: system temp directory)
      # @return [String]
      def build_path(options = {})
        if options[:download_path].nil?
          "#{DEFAULT_TEMPDIR}/#{@video.id}"
        elsif File.directory?(options[:download_path])
          "#{options[:download_path]}/#{@video.id}"
        else
          options[:download_path]
        end
      end

      # Command line to download the video file
      # @param [Hash] options
      # @option options [String, File] :download_path Path where download should be stored (default: system temp directory)
      # @option options [String] :flags Flags to pass to youtube-dl
      # @return [String]
      def command_line(options = {})
        download_path = path(options)
        output_flag = "-o '#{download_path}.%(ext)s'"
        "youtube-dl #{@video.source_url} #{FORMAT_ARG} #{options[:flags]} #{output_flag}"
      end

    end

  end

end
