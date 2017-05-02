module Viddl

  module Video

    class Download

      TEMPDIR = "/tmp"

      def self.process(video, options = {})
        new(video).process(options)
      end

      def initialize(video)
        @video = video
      end

      def process(options = {})
        result = system(command_line)
        raise(result.to_s) unless result
        true
      end

      private

      def command_line
        "youtube-dl #{@video.source_url} -o '#{TEMPDIR}/#{@video.id}s.%(ext)s'"
      end

    end

  end

end
