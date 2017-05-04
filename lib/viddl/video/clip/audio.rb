module Viddl

  module Video

    class Clip

      module Audio

        extend self

        # Audio options formatted for ffmpeg
        # @param [Hash] options
        # @option options [Boolean] :audio Whether to include audio (default: true)
        # @return [Hash]
        def options_formatted(options = {})
          result = {}
          result[:audio] = !options[:audio].eql?(false)
          result
        end

        # Command line options for audio
        # @param [Hash] options
        # @option options [Boolean] :audio Whether to include audio (default: false)
        # @return [String, nil]
        def args(options = {})
          "-an" if options[:audio].eql?(false)
        end

        # Token added to clip filename for audio args
        # @param [Hash] options
        # @option options [Boolean] :audio Whether to include audio in the clip (default: false)
        # @return [String, nil]
        def filename_token(options = {})
          "noaudio" if options[:audio].eql?(false)
        end

      end

    end

  end

end
