module Viddl

  module Video

    class Clip

      module Resize

        extend self

        # Resize options formatted for ffmpeg
        # @param [Hash] options
        # @option options [Integer, String] :width The desired width to resize to
        # @option options [Integer, String] :height The desired height to resize to
        # @return [Hash]
        def options_formatted(options = {})
          result = {}
          result[:height] = options[:height].to_i unless options[:height].nil?
          result[:width] = options[:width].to_i unless options[:width].nil?
          result
        end

        # Command line options for resize
        # @param [Hash] options
        # @option options [Integer] :width The desired width to resize to
        # @option options [Integer] :height The desired height to resize to
        # @return [String]
        def args(options = {})
          scale = if options[:width].nil? && !options[:height].nil?
            "-1:#{options[:height]}"
          elsif !options[:width].nil? && options[:height].nil?
            "#{options[:width]}:-1"
          elsif !options[:width].nil? && !options[:height].nil?
            "#{options[:width]}:#{options[:height]}"
          end
          if scale.nil?
            ""
          else
            "-vf scale=#{scale}"
          end
        end

        # Token added to clip filename for resize args
        # @param [Hash] options
        # @option options [Integer] :width The desired width to resize to
        # @option options [Integer] :height The desired height to resize to
        # @return [String]
        def filename_token(options = {})
          args = ""
          unless options[:width].nil?
            args += "w#{options[:width]}"
          end
          unless options[:height].nil?
            args += "h#{options[:height]}"
          end
          args
        end

      end

    end

  end

end
