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
        def filter_args(options = {})
          unless options[:crop].nil?
            crop = options[:crop]
            "crop=#{crop[:width]}:#{crop[:height]}:#{crop[:x]}:#{crop[:y]}"
          end
        end

        # Token added to clip filename for crop args
        # @param [Hash] options
        # @option options [Hash] :crop The desired crop parameters (:x, :y, :width, :height)
        # @return [String, nil]
        def filename_token(options = {})
          unless options[:crop].nil?
            crop = options[:crop]
            "cx#{crop[:x]}cy#{crop[:y]}cw#{crop[:width]}ch#{crop[:height]}"
          end
        end

      end

    end

  end

end
