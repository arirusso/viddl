require "pathname"

require "viddl/video/clip/audio"
require "viddl/video/clip/crop"
require "viddl/video/clip/cut"
require "viddl/video/clip/resize"

module Viddl

  module Video

    class Clip

      MODULES = [Audio, Crop, Cut, Resize]

      # Create a clip using the given video source file path and options
      # @param [String] source_path Path to video file to create clip from
      # @param [Hash] options
      # @option options [Boolean] :audio Whether to include audio
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @option options [Integer, String] :width The desired width to resize to
      # @option options [Integer, String] :height The desired height to resize to
      # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
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
      # @option options [Boolean] :audio Whether to include audio
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Numeric] :end Time in the source file where the clip ends
      # @option options [Integer, String] :width The desired width to resize to
      # @option options [Integer, String] :height The desired height to resize to
      # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
      # @return [Boolean]
      def process(options = {})
        command = command_line(options)
        Kernel.system(command)
      end

      # Path of the created clip
      # @return [Pathname]
      def path
        if !@path.nil? && File.exists?(@path)
          @path
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
          populate_output_path
          "cp #{@source_path} #{@path.to_s}"
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

          populate_output_path(formatted_opts)
          "ffmpeg -i #{@source_path} #{module_arg_string} #{@path.to_s}"
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

      # Set the clip path
      # @param [Hash] options
      # @option options [Boolean] :audio Whether to include audio
      # @option options [Numeric] :start Time in the source file where the clip starts
      # @option options [Numeric] :duration Duration of the clip
      # @option options [Integer, String] :width The desired width to resize to
      # @option options [Integer, String] :height The desired height to resize to
      # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
      # @return [String]
      def populate_output_path(options = {})
        base = @source_path.scan(/#{Download::TEMPDIR}\/(.*)/).flatten.first
        result = base
        if !options.values.flatten.compact.empty?
          name, ext = *base.split(".")
          tokens = ""
          MODULES.each do |mod|
            token = mod.filename_token(options)
            tokens += "-#{token}" unless token.nil?
          end
          result = "#{name}#{tokens}.#{ext}"
        end
        @path = Pathname.new(result)
      end

    end

  end

end
