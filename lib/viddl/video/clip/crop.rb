module Viddl

  module Video

    class Clip

      module Crop

        extend self

        # Crop options formatted for ffmpeg
        # @param [Hash] options
        # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
        # @return [Hash]
        def options_formatted(options = {})
          result = {}
          unless options[:crop].nil?
            crop = {}
            [:x, :y, :width, :height].each do |property|
              if options[:crop][property].nil?
                raise "Crop is missing required #{property} property"
              else
                crop[property] = options[:crop][property].to_i
              end
            end
            result[:crop] = crop
          end
          result
        end

        # Command line options for cropping
        # @param [Hash] options
        # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
        # @return [String]
        def args(options = {})
          if options[:crop].nil?
            ""
          else
            crop = options[:crop]
            "-filter:v 'crop=#{crop[:x]}:#{crop[:y]}:#{crop[:width]}:#{crop[:height]}'"
          end
        end

        # Token added to clip filename for crop args
        # @param [Hash] options
        # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
        # @return [String]
        def filename_token(options = {})
          args = ""
          if options[:crop].nil?
            ""
          else
            crop = options[:crop]
            "cx#{crop[:x]}cy#{crop[:y]}cw#{crop[:width]}ch#{crop[:height]}'"
          end
          args
        end

      end

    end

  end

end
