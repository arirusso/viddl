require "helper"

describe Viddl::Video::Instance do

  before(:each) do
    @yt_video_id = "6g4dkBF5anU"
    @source_url = "https://youtube.com/watch?v=#{@yt_video_id}"
    @video = Viddl::Video::Instance.new(@source_url)
  end

  context "#populate_id" do

    it "populates id" do
      expect(@video.id).to_not(be_nil)
      expect(@video.id.length).to(eq(10))
    end

  end

  context "#source_filenames" do

    context "with associated download" do

      it "pulls filenames from directory" do
        @download = Viddl::Video::Download.new(@video)
        expect(Dir).to(receive(:[]))
        @result = @video.source_filenames
      end

    end

    context "with no associated download" do

      it "raises" do
        expect {
          @video.source_filenames
        }.to(raise_error(RuntimeError))
      end

    end

  end

  context "#create_clip" do

    before(:each) do
      @download = Viddl::Video::Download.new(@video)
      expect(@video).to(receive(:source_filenames).and_return(["#{Viddl::Video::Download::TEMPDIR}/#{@video_id}.mkv"]))
    end

    context "with no options" do

      it "execs command line" do
        @options = {}
        expect(Kernel).to(receive(:system))
        @result = @video.create_clip(@options)
      end

    end

    context "with duration" do

      it "execs command line" do
        @options = {
          duration: 12
        }
        expect(Kernel).to(receive(:system))
        @result = @video.create_clip(@options)
      end

    end

    context "with start time and duration" do

      it "execs command line" do
        @options = {
          start: 10,
          duration: 15
        }
        expect(Kernel).to(receive(:system))
        @result = @video.create_clip(@options)
      end

    end

    context "with start and end time" do

      it "execs command line" do
        @options = {
          start: 8,
          end: 15
        }
        expect(Kernel).to(receive(:system))
        @result = @video.create_clip(@options)
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
          @video.create_clip(@options)
        }.to(raise_error(RuntimeError))
      end

    end

  end

  context "#process_download" do

    context "with no options" do

      it "execs command line" do
        @options = {}
        expect(Kernel).to(receive(:system).and_return(true))
        @result = @video.process_download(@options)
      end

    end

  end

end
