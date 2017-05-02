module Viddl

  module Video

    class Clip

      def self.process(path, options = {})
        new(path).process(options)
      end

      def initialize(path)
        @source_path = path
      end

      def process(options = {})
        p command_line(options)
        system(command_line(options))
      end

      private

      def command_line(options)
        "ffmpeg -i #{@source_path} #{time_args(options)} -c:v copy -c:a copy #{output_path}"
      end

      def time_args(options = {})
        args = ""
        if !options[:start].nil?
          args += " -ss #{options[:start]}"
        end
        if !options[:duration].nil? && options[:end].nil?
          args += " -t #{options[:duration]}"
        elsif options[:duration].nil? && !options[:end].nil?
          duration = options[:end] - options[:start]
          args += " -t #{duration}"
        end
        args
      end

      def output_path
        @source_path.scan(/#{Download::TEMPDIR}\/(.*)/).flatten.first
      end

    end

  end

end
