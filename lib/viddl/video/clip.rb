module Viddl

  module Video

    class Clip

      # Create a clip using the given video source file path and options
      # @param [String] source_path Path to video file to create clip from
      # @param [Hash] options
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @return [Clip]
      def self.process(path, options = {})
        clip = new(path)
        clip.process(options)
        clip
      end

      # @param [String] source_path Path to video file to create clip from
      def initialize(source_path)
        @source_path = source_path
      end

      # Create a clip using the given options
      # @param [Hash] options
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @return [Boolean]
      def process(options = {})
        Kernel.system(command_line(options))
      end

      private

      # Command line to create a clip from the source file and given options
      # @param [Hash] options
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @return [String]
      def command_line(options = {})
        opts = options_formatted(options)
        optional_args = " #{time_args(opts)} #{audio_args(opts)}"
        "ffmpeg -i #{@source_path}#{optional_args} -c:v copy -c:a copy #{output_path(opts)}"
      end

      # Options formatted for ffmpeg
      # @param [Hash] options
      # @option options [Boolean] :audio Whether to include audio (default: true)
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @return [Hash]
      def options_formatted(options = {})
        result = {}
        result[:audio] = true unless options[:audio] === false
        result[:start] = options[:start]
        result[:duration] = duration_from_options(options)
        result
      end

      # Numeric duration for the given options
      # @param [Hash] options
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @return [Numeric]
      def duration_from_options(options = {})
        duration = nil
        if !options[:duration].nil? && !options[:end].nil?
          raise "Can not use both end time and duration"
        elsif !options[:duration].nil? && options[:end].nil?
          duration = options[:duration]
        elsif options[:duration].nil? && !options[:end].nil?
          duration = options[:end] - options[:start]
        end
        duration
      end

      # Command line options for the given time constraints
      # @param [Hash] options
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @return [String]
      def time_args(options = {})
        args = ""
        unless options[:start].nil?
          args += " -ss #{options[:start]}"
        end
        unless options[:duration].nil?
          args += " -t #{options[:duration]}"
        end
        args
      end

      # Command line options for audio
      # @param [Hash] options
      # @option options [Boolean] :audio Whether to include audio (default: true)
      # @return [Hash]
      def audio_args(options = {})
        args = ""
        unless options[:audio]
          args += " -an"
        end
        args
      end

      # Path of the created clip
      # @param [Hash] options
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @return [String]
      def output_path(options = {})
        base = @source_path.scan(/#{Download::TEMPDIR}\/(.*)/).flatten.first
        result = base
        if !options.values.flatten.compact.empty?
          name, ext = *base.split(".")
          option_string = ""
          unless options[:start].nil?
            option_string += "s#{options[:start]}"
          end
          unless options[:duration].nil?
            option_string += "d#{options[:duration]}"
          end
          if !option_string.empty?
            option_string = "-#{option_string}"
          end
          unless options[:audio]
            option_string += "-noaudio"
          end
          result = "#{name}#{option_string}.#{ext}"
        end
        result
      end

    end

  end

end
