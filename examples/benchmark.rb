#!/usr/bin/env ruby
$:.unshift(File.join("..", "lib"))

require "viddl"
require "benchmark"

Benchmark.bm do |x|
  x.report do
    video = Viddl::Video.download("https://www.youtube.com/watch?v=6g4dkBF5anU") do |video, stream|
      video.create_clip(stream, start: 5, end: 10) rescue nil
    end
  end
end
