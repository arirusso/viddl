#!/usr/bin/env ruby
$:.unshift(File.join("..", "lib"))

require "viddl"

video = Viddl::Video.download("https://www.youtube.com/watch?v=6g4dkBF5anU") do |video, stream|

# Uncomment for full clip
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU`
# video.create_clip
# Uncomment for cut
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU -s 5 -e 10`
  video.create_clip(stream, start: 5, end: 10)
end

# Uncomment for cut with duration
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU -s 5 -d 5`
# video.create_clip(start: 5, duration: 5)

# Uncomment for resize
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU -w 320 -h 240`
# video.create_clip(width: 320, height: 240)

# Uncomment for crop
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU --cx 100 --cy 100 --cw 60 --ch 60`
# video.create_clip(crop: { x: 100, y: 100, width: 60, height: 60 })

# Uncomment for resize proportional
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU -w 240`
# video.create_clip(width: 240)

# Uncomment for no audio
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU --no-audio`
# video.create_clip(audio: false)

# Uncomment for cut and resize
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU -s 3 -d 2 -w 160 -h 120`
# video.create_clip(start: 3, duration: 2, width: 160, height: 120)

# Uncomment for cut and resize and crop
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU -s 3 -d 2 -w 160 -h 120 --cx 100 --cy 100 --cw 120 --ch 120`
# video.create_clip(start: 3, duration: 2, width: 320, height: 240, crop: { x: 10, y: 10, width: 12, height: 12 })

# Uncomment for cut, resize and no audio
# comparable to command line `viddl https://www.youtube.com/watch?v=6g4dkBF5anU -s 2 -e 3.5 -w 1920 -h 1280 --no-audio`
# video.create_clip(start: 2, end: 3.5, width: 1920, height: 1280, audio: false)
