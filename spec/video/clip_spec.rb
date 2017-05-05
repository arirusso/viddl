require "helper"

describe Viddl::Video::Clip do

  before(:each) do
    @source_file = "#{Viddl::Video::Download::TEMPDIR}/6g4dkBF5anU.mkv"
    @clip = Viddl::Video::Clip.new(@source_file)
  end

  context "#process" do

    context "with no options" do

      it "execs command line" do
        @options = {}
        expect(Kernel).to receive(:system)
        @result = @clip.send(:process, @options)
      end

    end

    context "cut options" do

      context "with duration" do

        it "execs command line" do
          @options = {
            duration: 12
          }
          expect(Kernel).to receive(:system)
          @result = @clip.send(:process, @options)
        end

      end

      context "with start time and duration" do

        it "execs command line" do
          @options = {
            start: 10,
            duration: 15
          }
          expect(Kernel).to receive(:system)
          @result = @clip.send(:process, @options)
        end

      end

      context "with start and end time" do

        it "execs command line" do
          @options = {
            start: 8,
            end: 15
          }
          expect(Kernel).to receive(:system)
          @result = @clip.send(:process, @options)
        end

      end

      context "with start, end time and duration" do

        it "raises" do
          @options = {
            duration: 5,
            end: 15,
            start: 10
          }
          expect {
            @clip.send(:process, @options)
          }.to(raise_error(RuntimeError))
        end

      end

    end

  end

  context "#command_line" do

    context "with no options" do

      before(:each) do
        @options = {}
        @result = @clip.send(:command_line, @options)
      end

      it "includes file name" do
        expect(@result).to(include(@source_file))
      end

      it "has no time args" do
        expect(@result).to_not(include("-ss"))
        expect(@result).to_not(include("-t"))
      end

      it "has no audio off option" do
        expect(@result).to_not(include("-an"))
      end

    end

    context "with audio = false" do

      before(:each) do
        @options = {
          audio: false
        }
        @result = @clip.send(:command_line, @options)
      end

      it "includes file name" do
        expect(@result).to(include(@source_file))
      end

      it "has duration" do
        expect(@result).to(include("-an"))
      end

    end

    context "with crop options" do

      context "incomplete" do

        it "raises" do
          @options = {
            crop: {
              x: 1
            }
          }
          expect {
            @clip.send(:command_line, @options)
          }.to(raise_error(RuntimeError))
        end

      end

      context "valid" do

        before(:each) do
          @options = {
            crop: {
              x: 150,
              y: 160,
              width: 170,
              height: 180
            }
          }
          @result = @clip.send(:command_line, @options)
        end

        it "has correct scale arg" do
          expect(@result).to(include("-vf"))
          expect(@result).to(include("crop=170:180:150:160"))
        end

      end

    end

    context "with resize options" do

      context "with width only" do

        before(:each) do
          @options = {
            width: 1024
          }
          @result = @clip.send(:command_line, @options)
        end

        it "has correct scale arg" do
          expect(@result).to(include("-vf"))
          expect(@result).to(include("scale=1024:-1"))
        end

      end

      context "with height only" do

        before(:each) do
          @options = {
            height: 768
          }
          @result = @clip.send(:command_line, @options)
        end

        it "has correct scale arg" do
          expect(@result).to(include("-vf"))
          expect(@result).to(include("scale=-1:768"))
        end

      end

      context "with width and height" do

        before(:each) do
          @options = {
            width: 1920,
            height: 1280
          }
          @result = @clip.send(:command_line, @options)
        end

        it "has correct scale arg" do
          expect(@result).to(include("-vf"))
          expect(@result).to(include("scale=1920:1280"))
        end

      end

    end

    context "with cut options" do

      context "with duration" do

        before(:each) do
          @options = {
            duration: 12
          }
          @result = @clip.send(:command_line, @options)
        end

        it "includes file name" do
          expect(@result).to(include(@source_file))
        end

        it "has duration" do
          expect(@result).to_not(include("-ss"))
          expect(@result).to(include("-t 12"))
        end

      end

      context "with start time and duration" do

        before(:each) do
          @options = {
            start: 10,
            duration: 15
          }
          @result = @clip.send(:command_line, @options)
        end

        it "includes file name" do
          expect(@result).to(include(@source_file))
        end

        it "has duration and start time" do
          expect(@result).to(include("-ss 10"))
          expect(@result).to(include("-t 15"))
        end

      end

      context "with start and end time" do

        before(:each) do
          @options = {
            start: 8,
            end: 15
          }
          @result = @clip.send(:command_line, @options)
        end

        it "includes file name" do
          expect(@result).to(include(@source_file))
        end

        it "has duration and start time" do
          expect(@result).to(include("-ss 8"))
          expect(@result).to(include("-t 7"))
        end

      end

      context "with start, end time and duration" do

        it "raises" do
          @options = {
            duration: 5,
            end: 15,
            start: 10
          }
          expect {
            @clip.send(:command_line, @options)
          }.to(raise_error(RuntimeError))
        end

      end

    end

  end

  context "#output_path" do

    context "with no options" do

      it "matches source path file name" do
        path = @clip.send(:output_path)
        expect(path).to(eq("6g4dkBF5anU.mkv"))
      end

    end

    context "crop options" do

      context "valid" do

        it "has crop options in filename" do
          options = {
            crop: {
              x: 200,
              y: 210,
              width: 220,
              height: 230
            }
          }
          path = @clip.send(:output_path, options)
          expect(path).to(eq("6g4dkBF5anU-cx200cy210cw220ch230.mkv"))
        end

      end

    end

    context "resize options" do

      context "with width only" do

        it "has width" do
          options = {
            width: 640
          }
          path = @clip.send(:output_path, options)
          expect(path).to(eq("6g4dkBF5anU-w640.mkv"))
        end

      end

      context "with height only" do

        it "has width" do
          options = {
            height: 480
          }
          path = @clip.send(:output_path, options)
          expect(path).to(eq("6g4dkBF5anU-h480.mkv"))
        end

      end

      context "with width and height" do

        it "has width" do
          options = {
            width: 1280,
            height: 720
          }
          path = @clip.send(:output_path, options)
          expect(path).to(eq("6g4dkBF5anU-w1280h720.mkv"))
        end

      end

    end

    context "with no audio" do

      it "has no audio option" do
        options = {
          audio: false
        }
        path = @clip.send(:output_path, options)
        expect(path).to(eq("6g4dkBF5anU-noaudio.mkv"))
      end

    end

    context "cut options" do

      context "with start time" do

        it "matches source path file name" do
          options = {
            audio: true,
            start: 10
          }
          path = @clip.send(:output_path, options)
          expect(path).to(eq("6g4dkBF5anU-s10.mkv"))
        end

      end

      context "with duration" do

        it "matches source path file name" do
          options = {
            audio: true,
            duration: 1.5
          }
          path = @clip.send(:output_path, options)
          expect(path).to(eq("6g4dkBF5anU-d1.5.mkv"))
        end

      end

      context "with start time and duration" do

        it "matches source path file name" do
          options = {
            audio: true,
            duration: 12,
            start: 6
          }
          path = @clip.send(:output_path, options)
          expect(path).to(eq("6g4dkBF5anU-s6d12.mkv"))
        end

      end

    end

  end

  context "#options_formatted" do

    it "formats options for each module" do
      options = {}
      expect(Viddl::Video::Clip::Audio).to(receive(:options_formatted).and_return({}))
      expect(Viddl::Video::Clip::Cut).to(receive(:options_formatted).and_return({}))
      expect(Viddl::Video::Clip::Resize).to(receive(:options_formatted).and_return({}))
      @clip.send(:options_formatted, options)
    end

  end

end
