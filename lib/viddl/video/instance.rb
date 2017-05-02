module Viddl

  module Video

    class Instance

      attr_reader :id, :source_url

      def initialize(url)
        @source_url = url

        populate_id
      end

      def cut(options = {})
        filenames.map do |filename|
          Clip.process(filename, options)
        end
      end

      def download(options = {})
        @is_downloaded = Download.process(self, options)
      end

      def filenames
        if @is_downloaded
          @filenames = Dir["#{Download::TEMPDIR}/#{@id}*"]
        else
          raise "File must be downloaded"
        end
      end

      private

      def populate_id
        @id = @source_url.scan(/youtube.com\/watch\?v\=(\S*)&?/).flatten.first
      end

    end

  end

end
