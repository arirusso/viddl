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
          [:width, :height].each do |property|
            result[property] = options[property].to_i unless options[property].nil?
          end
          result
        end

        # Command line options for resize
        # @param [Hash] options
        # @option options [Integer] :width The desired width to resize to
        # @option options [Integer] :height The desired height to resize to
        # @return [String, nil]
        def filter_args(options = {})
          scale = if options[:width].nil? && !options[:height].nil?
            "-1:#{options[:height]}"
          elsif !options[:width].nil? && options[:height].nil?
            "#{options[:width]}:-1"
          elsif !options[:width].nil? && !options[:height].nil?
            "#{options[:width]}:#{options[:height]}"
          end
          unless scale.nil?
            "scale=#{scale}"
          end
        end

        # Token added to clip filename for resize args
        # @param [Hash] options
        # @option options [Integer] :width The desired width to resize to
        # @option options [Integer] :height The desired height to resize to
        # @return [String, nil]
        def filename_token(options = {})
          if !options[:width].nil? || !options[:height].nil?
            args = ""
            if !options[:width].nil?
              args += "w#{options[:width]}"
            end
            if !options[:height].nil?
              args += "h#{options[:height]}"
            end
            args
          end
        end

      end

    end

  end

end
