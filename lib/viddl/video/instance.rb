require "digest"

module Viddl

  module Video

    class Instance

      attr_accessor :download
      attr_reader :id, :source_url

      ID_LENGTH = 10

      # @param [String] url The url of the video source
      def initialize(url)
        @source_url = url

        populate_id
      end

      # Cut the video source using the given options
      # @param [Hash] options
      # @option options [Boolean] :audio Whether to include audio
      # @option options [String] :flags Flags to pass to ffmpeg
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @option options [Integer, String] :width The desired width to resize to
      # @option options [Integer, String] :height The desired height to resize to
      # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
      # @option options [Pathname, String] :output_path path where clip will be written. Can be directory or filename
      # @return [Array<Clip>]
      def create_clip(options = {})
        download_paths.map do |path|
          Clip.process(path, options)
        end
      end

      # Download the video source
      # @param [Hash] options
      # @option options [String, File] :download_path Path where download should be stored (default: system temp directory)
      # @option options [String] :flags Flags to pass to youtube-dl
      # @return [Download]
      def process_download(options = {})
        @download = Download.process(self, options)
      end

      # The downloaded files to work from
      # @return [Array<String>, Array<File>]
      def download_paths
        if @download.nil?
          raise "File must be downloaded"
        else
          @download.paths
        end
      end

      private

      # The video instance id
      # @return [String]
      def populate_id
        @id = Digest::SHA256.hexdigest(@source_url).slice(0, ID_LENGTH)
      end

    end

  end

end
