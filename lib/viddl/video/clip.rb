require "viddl/video/clip/audio"
require "viddl/video/clip/crop"
require "viddl/video/clip/cut"
require "viddl/video/clip/resize"

module Viddl

  module Video

    class Clip

      MODULES = [Audio, Crop, Cut, Resize]

      # Create a clip using the given video source file path and options
      # @param [String] id
      # @param [Hash] options
      # @option options [Boolean] :audio Whether to include audio
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @option options [Integer, String] :width The desired width to resize to
      # @option options [Integer, String] :height The desired height to resize to
      # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
      # @return [Clip]
      def self.process(id, stream, options = {})
        clip = new(id)
        clip.process(stream, options)
        clip
      end

      # @param [String] id
      def initialize(id)
        @id = id
      end

      # Create a clip using the given options
      # @param [Hash] options
      # @option options [Boolean] :audio Whether to include audio
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @option options [Integer, String] :width The desired width to resize to
      # @option options [Integer, String] :height The desired height to resize to
      # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
      # @return [Boolean]
      def process(stream, options = {})
        command = command_line(options)
        Open3.popen2(command) do |f_stdin, f_stdout|
          IO.copy_stream(stream, f_stdin)
        end
      end

      private

      # Command line to create a clip from the source file and given options
      # @param [Hash] options
      # @option options [Boolean] :audio Whether to include audio
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @option options [Integer, String] :width The desired width to resize to
      # @option options [Integer, String] :height The desired height to resize to
      # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
      # @return [String]
      def command_line(options = {})
        if options.values.compact.empty?
          # when there are no clip options, the source file can just be copied
          # over to the output file location without using ffmpeg
          "tee #{@id}.mkv"
        else
          formatted_opts = options_formatted(options)

          modules_with_args = MODULES.select { |mod| mod.respond_to?(:args) }
          modules_with_filters = MODULES.select { |mod| mod.respond_to?(:filter_args) }

          module_args = modules_with_args.map { |mod| mod.args(formatted_opts) }.compact
          module_filters = modules_with_filters.map { |mod| mod.filter_args(formatted_opts) }.compact

          module_arg_string = module_args.join(" ")
          unless module_filters.empty?
            module_arg_string += " -vf '#{module_filters.join(",")}'"
          end

          "ffmpeg -i pipe:0 #{module_arg_string} #{@id}.m4v"
        end
      end

      # Options formatted for ffmpeg
      # @param [Hash] options
      # @option options [Boolean] :audio Whether to include audio (default: true)
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @option options [Integer, String] :width The desired width to resize to
      # @option options [Integer, String] :height The desired height to resize to
        # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
      # @return [Hash]
      def options_formatted(options = {})
        mod_options = MODULES.map { |mod| mod.options_formatted(options) }
        mod_options.inject(:merge)
      end

    end

  end

end
