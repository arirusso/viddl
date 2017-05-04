module Viddl

  module Video

    class Clip

      module Audio

        extend self

        # Command line options for audio
        # @param [Hash] options
        # @option options [Boolean] :audio Whether to include audio (default: false)
        # @return [Hash]
        def args(options = {})
          args = ""
          unless options[:audio]
            args += "-an"
          end
          args
        end

        # Token added to clip filename for audio args
        # @param [Hash] options
        # @option options [Boolean] :audio Whether to include audio in the clip (default: false)
        # @return [String]
        def filename_token(options = {})
          args = ""
          unless options[:audio]
            args += "-noaudio"
          end
          args
        end

      end

    end

  end

end
