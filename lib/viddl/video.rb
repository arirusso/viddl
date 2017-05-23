require "viddl/video/clip"
require "viddl/video/download"
require "viddl/video/instance"

module Viddl

  module Video

    extend self

    # Download a video using the given url
    # @param [String] url
    # @param [Hash] options
    # @option options [String, File] :download_path Path where download should be stored (default: system temp directory)
    # @option options [String] :flags Flags to pass to youtube-dl
    # @return [Video::Instance]
    def download(url, options = {})
      video = Instance.new(url)
      video.process_download(options)
      video
    end

  end

end
