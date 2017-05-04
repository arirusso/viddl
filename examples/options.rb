#!/usr/bin/env ruby
$:.unshift(File.join("..", "lib"))

require "viddl"

video = Viddl::Video.download("https://www.youtube.com/watch?v=6g4dkBF5anU")

# Uncomment for full clip
# video.create_clip

# Uncomment for cut
# video.create_clip(start: 5, end: 10)

# Uncomment for resize
# video.create_clip(width: 320, height: 240)

# Uncomment for no audio
#video.create_clip(audio: false)

# Uncomment for cut and resize
# video.create_clip(start: 5, end: 10, width: 160, height: 120)

# Uncomment for cut, resize and no audio
# video.create_clip(start: 5, end: 10, width: 960, height: 720, audio: false)
