#
# viddl
#
# (c)2017 Ari Russo
# Apache 2.0 License
# https://github.com/arirusso/viddl
#

# modules
require "viddl/system"
require "viddl/video"

module Viddl

  extend self

  VERSION = "0.0.1"

  # Download a video using the given url
  # @param [String] url
  # @param [Hash] options
  # @return [Video::Instance]
  def download(url, options = {})
    System.validate
    Video.download(url, options)
  end

end
