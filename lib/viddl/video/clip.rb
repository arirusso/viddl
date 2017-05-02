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
        system(command_line(options))
      end

      private

      # Command line to create a clip from the source file and given options
      # @param [Hash] options
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @return [String]
      def command_line(options = {})
        "ffmpeg -i #{@source_path} #{time_args(options)} -c:v copy -c:a copy #{output_path}"
      end

      # Command line options for the given time constraints
      # @param [Hash] options
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @return [String]
      def time_args(options = {})
        args = ""
        if !options[:start].nil?
          args += " -ss #{options[:start]}"
        end
        if !options[:duration].nil? && !options[:end].nil?
          raise "Can not use both end time and duration"
        elsif !options[:duration].nil? && options[:end].nil?
          args += " -t #{options[:duration]}"
        elsif options[:duration].nil? && !options[:end].nil?
          duration = options[:end] - options[:start]
          args += " -t #{duration}"
        end
        args
      end

      # Path of the created clip
      # @return [String]
      def output_path
        @source_path.scan(/#{Download::TEMPDIR}\/(.*)/).flatten.first
      end

    end

  end

end
