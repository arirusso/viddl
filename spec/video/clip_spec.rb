require "helper"

describe Viddl::Video::Clip do

  before(:each) do
    @clip = Viddl::Video::Clip.new("/tmp/6g4dkBF5anU.mkv")
  end

  context "#output_path" do

    context "with no args" do

      it "matches source path file name" do
        path = @clip.send(:output_path)
        expect(path).to(eq("6g4dkBF5anU.mkv"))
      end

    end

    context "with start time" do

      it "matches source path file name" do
        options = {
          start: 10
        }
        path = @clip.send(:output_path, options)
        expect(path).to(eq("6g4dkBF5anU-s10.mkv"))
      end

    end

    context "with duration" do

      it "matches source path file name" do
        options = {
          duration: 1.5
        }
        path = @clip.send(:output_path, options)
        expect(path).to(eq("6g4dkBF5anU-d1.5.mkv"))
      end

    end

    context "with start time and duration" do

      it "matches source path file name" do
        options = {
          duration: 12,
          start: 6
        }
        path = @clip.send(:output_path, options)
        expect(path).to(eq("6g4dkBF5anU-s6d12.mkv"))
      end

    end

  end

  context "#duration_from_options" do

    context "with end time" do

      it "has correct duration" do
        options = {
          start: 10,
          end: 15
        }
        args = @clip.send(:duration_from_options, options)
        expect(args).to(eq(5))
      end

    end

    context "with end time and duration" do

      it "raises" do
        options = {
          duration: 3,
          end: 15
        }
        expect {
          @clip.send(:duration_from_options, options)
        }.to(raise_error(RuntimeError))
      end

    end

  end

  context "#time_args" do

    context "with only start time" do

      it "has correct args" do
        options = {
          start: 10
        }
        args = @clip.send(:time_args, options)
        expect(args).to(eq(" -ss 10"))
      end

    end

    context "with start time and duration" do

      it "has correct args" do
        options = {
          start: 10,
          duration: 15
        }
        args = @clip.send(:time_args, options)
        expect(args).to(eq(" -ss 10 -t 15"))
      end

    end

  end

end
