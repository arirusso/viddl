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
    def download(url, options = {})
      video = Instance.new(url)
      video.download(options)
      video
    end

  end

end
