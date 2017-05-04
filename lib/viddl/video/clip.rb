require "viddl/video/clip/audio"
require "viddl/video/clip/crop"
require "viddl/video/clip/cut"
require "viddl/video/clip/resize"

module Viddl

  module Video

    class Clip

      MODULES = [Audio, Cut, Resize]

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
        if options.values.compact.empty?
          # when there are no clip options, the source file can just be copied
          # over to the output file location without using ffmpeg
          "cp #{@source_path} #{output_path}"
        else
          formatted_opts = options_formatted(options)
          module_args = ""
          module_args = MODULES.map { |mod| mod.args(formatted_opts) }
          module_arg_string = module_args.compact.reject(&:empty?).join(" ")
          "ffmpeg -i #{@source_path} #{module_arg_string} -c:v copy -c:a copy #{output_path(formatted_opts)}"
        end
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
        result.merge!(Audio.options_formatted(options))
        result.merge!(Cut.options_formatted(options))
        result
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
          tokens = ""
          MODULES.each do |mod|
            token = mod.filename_token(options)
            tokens += "-#{token}" unless token.empty?
          end
          result = "#{name}#{tokens}.#{ext}"
        end
        result
      end

    end

  end

end
