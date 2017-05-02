require "helper"

describe Viddl::Video::Clip do

  before(:each) do
    @clip = Viddl::Video::Clip.new("/tmp/6g4dkBF5anU.mkv")
  end

  context "#output_path" do

    it "matches source path file name" do
      path = @clip.send(:output_path)
      expect(path).to(eq("6g4dkBF5anU.mkv"))
    end
    
  end

  context "#time_args" do

    it "has correct args with only start time" do
      options = {
        start: 10
      }
      args = @clip.send(:time_args, options)
      expect(args).to(eq(" -ss 10"))
    end

    it "has correct args with start time and end time" do
      options = {
        start: 10,
        end: 15
      }
      args = @clip.send(:time_args, options)
      expect(args).to(eq(" -ss 10 -t 5"))
    end

    it "has correct args with start time and duration" do
      options = {
        start: 10,
        duration: 15
      }
      args = @clip.send(:time_args, options)
      expect(args).to(eq(" -ss 10 -t 15"))
    end

    it "raises if end time and duration are included" do
      options = {
        start: 10,
        end: 15,
        duration: 3
      }
      expect { @clip.send(:time_args, options) }.to(raise_error(RuntimeError))
    end

  end

end
