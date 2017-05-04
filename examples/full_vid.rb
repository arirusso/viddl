#!/usr/bin/env ruby
$:.unshift(File.join("..", "lib"))

require "viddl"

video = Viddl::Video.download("https://www.youtube.com/watch?v=6g4dkBF5anU")
p video.source_filenames
