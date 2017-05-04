# Viddl

Use Viddl to quickly download, cut, crop and resize videos

Viddl can be used at the [command line](#command-line) or in [Ruby](#ruby)

It requires that both [youtube-dl](https://github.com/rg3/youtube-dl) and [ffmpeg](https://ffmpeg.org) are installed before using.

## Usage

Running Viddl generates video clip files in the current directory

### Command Line

The command line usage and options are as follows:

#### Download

With no options, Viddl will download the original video

```sh
viddl https://www.youtube.com/watch?v=6g4dkBF5anU
```

#### Cut

This will start the clip at 10 seconds into the original video and run for five seconds

```sh
viddl https://www.youtube.com/watch?v=6g4dkBF5anU -s 10 -d 5
```

Alternately, this will start the clip at 15 seconds in the original video and stop at 22 seconds

```sh
viddl https://www.youtube.com/watch?v=6g4dkBF5anU -s 15 -e 22
```

#### Resize

This will resize to 640 x 480:

```sh
viddl https://www.youtube.com/watch?v=6g4dkBF5anU -w 640 -h 480
```

#### Crop

This will crop a 40x40 pixel box at position 20 x 20:

```sh
viddl https://www.youtube.com/watch?v=6g4dkBF5anU --cx 20 --cy 20 --cw 40 --ch 40
```

#### Strip Audio

Audio can be left out of the clip:

```sh
viddl https://www.youtube.com/watch?v=6g4dkBF5anU --no-audio
```

#### Combine

Any or all of these options can be used together:

```sh
viddl https://www.youtube.com/watch?v=6g4dkBF5anU -s 15 -e 22 --no-audio --cx 20 --cy 20 --cw 40 --ch 40 -w 640 -h 480
```

### Ruby

Similar to the command line, Ruby usage and options are as follows:

```ruby
options = {
  start: 15,
  end: 22,
  audio: false,
  crop: {
    x: 20,
    y: 20,
    width: 40,
    height: 40
  },
  width: 640,
  height: 480
}

video = Viddl::Video.download("https://www.youtube.com/watch?v=6g4dkBF5anU")
video.create_clip(options)
```

## License

Licensed under Apache 2.0, See the file LICENSE

Copyright (c) 2017 [Ari Russo](http://arirusso.com)
