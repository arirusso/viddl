require "helper"

describe Viddl::Video::Instance do

  before(:each) do
    @video_id = "6g4dkBF5anU"
    @source_url = "https://youtube.com/watch?v=#{@video_id}"
    @video = Viddl::Video::Instance.new(@source_url)
  end

  context "#clip" do

    before(:each) do
      @video.instance_variable_set("@download", Object.new)
      @video.stub(:source_filenames).and_return(["/tmp/#{@video_id}.mkv"])
    end

    context "with no options" do

      it "execs command line" do
        @options = {}
        expect(Kernel).to(receive(:system))
        @result = @video.clip(@options)
      end

    end

    context "with duration" do

      it "execs command line" do
        @options = {
          duration: 12
        }
        expect(Kernel).to(receive(:system))
        @result = @video.clip(@options)
      end

    end

    context "with start time and duration" do

      it "execs command line" do
        @options = {
          start: 10,
          duration: 15
        }
        expect(Kernel).to(receive(:system))
        @result = @video.clip(@options)
      end

    end

    context "with start and end time" do

      it "execs command line" do
        @options = {
          start: 8,
          end: 15
        }
        expect(Kernel).to(receive(:system))
        @result = @video.clip(@options)
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
          @video.clip(@options)
        }.to(raise_error(RuntimeError))
      end

    end

  end

  context "#download" do

    context "with no options" do

      it "execs command line" do
        @options = {}
        expect(Kernel).to(receive(:system).and_return(true))
        @result = @video.download(@options)
      end

    end

  end

end
