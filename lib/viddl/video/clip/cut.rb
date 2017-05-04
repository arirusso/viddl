module Viddl

  module Video

    class Clip

      module Cut

        extend self

        # Cut options formatted for ffmpeg
        # @param [Hash] options
        # @option options [Numeric] :start Time in the source file where the clip starts
        # @option options [Numeric] :duration Duration of the clip
        # @option options [Numeric] :end Time in the source file where the clip ends
        # @return [Hash]
        def options_formatted(options = {})
          result = {}
          result[:start] = options[:start]
          result[:duration] = duration(options)
          result
        end

        # Command line options for the given cut constraints
        # @param [Hash] options
        # @option options [Numeric] :start Time in the source file where the clip starts
        # @option options [Numeric] :duration Duration of the clip
        # @return [String]
        def args(options = {})
          args = ""
          unless options[:start].nil?
            args += " -ss #{options[:start]}"
          end
          unless options[:duration].nil?
            args += " -t #{options[:duration]}"
          end
          args
        end

        # Token added to clip filename for cut args
        # @param [Hash] options
        # @option options [Numeric] :start Time in the source file where the clip starts
        # @option options [Numeric] :duration Duration of the clip
        # @return [String]
        def filename_token(options = {})
          args = ""
          unless options[:start].nil?
            args += "s#{options[:start]}"
          end
          unless options[:duration].nil?
            args += "d#{options[:duration]}"
          end
          args
        end

        private

        # Numeric duration for the given options
        # @param [Hash] options
        # @option options [Numeric] :duration Duration of the clip
        # @option options [Numeric] :end Time in the source file where the clip ends
        # @return [Numeric]
        def duration(options = {})
          duration = nil
          if !options[:duration].nil? && !options[:end].nil?
            raise "Can not use both end time and duration"
          elsif !options[:duration].nil? && options[:end].nil?
            duration = options[:duration]
          elsif options[:duration].nil? && !options[:end].nil?
            duration = options[:end] - (options[:start] || 0)
          end
          duration
        end

      end

    end

  end

end
