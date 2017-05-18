require "base64"

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
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @option options [Integer, String] :width The desired width to resize to
      # @option options [Integer, String] :height The desired height to resize to
      # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
      # @option options [Pathname, String] :output_path path where clip will be written. Can be directory or filename
      # @return [Array<Clip>]
      def create_clip(options = {})
        source_filenames.map do |filename|
          Clip.process(filename, options)
        end
      end

      # Download the video source
      # @param [Hash] options
      # @return [Download]
      def process_download(options = {})
        @download = Download.process(self, options)
      end

      # The downloaded source filenames
      # @return [Array<String>]
      def source_filenames
        if @download.nil?
          raise "File must be downloaded"
        else
          @source_filenames = Dir["#{Download::TEMPDIR}/#{@id}*"]
        end
      end

      private

      # The video instance id
      # @return [String]
      def populate_id
        @id = Base64.encode64(@source_url).slice(0, ID_LENGTH)
      end

    end

  end

end
