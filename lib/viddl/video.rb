require "viddl/video/clip"
require "viddl/video/download"
require "viddl/video/instance"

module Viddl

  module Video

    extend self

    # Download a video using the given url
    # @param [String] url
    # @param [Hash] options
    # @return [Video::Instance]
    def download(url, options = {}, &block)
      video = Instance.new(url)
      video.process_download(options) do |stream|
        yield(video, stream)
      end
      video
    end

  end

end
