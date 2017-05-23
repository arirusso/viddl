require "helper"

describe Viddl::Video::Download do

  before(:each) do
    @video_id = "6g4dkBF5anU"
    @source_url = "https://youtube.com/watch?v=#{@video_id}"
    @video = Viddl::Video::Instance.new(@source_url)
    @download = Viddl::Video::Download.new(@video)
  end

  context "#process" do

    context "with no options" do

      it "execs command line" do
        @options = {}
        expect(Kernel).to(receive(:system).and_return(true))
        @result = @download.send(:process, @options)
      end

    end

  end

  context "#command_line" do

    context "with no download_path specified" do

      before(:each) do
        @result = @download.send(:command_line)
      end

      it "includes url" do
        expect(@result).to(include(@source_url))
      end

      it "includes temp dir" do
        expect(@result).to(include("#{Viddl::Video::Download::DEFAULT_TEMPDIR}/"))
      end

    end

    context "with download_path specified" do

      before(:each) do
        @path = "assets"
        @result = @download.send(:command_line, download_path: "assets")
      end

      it "includes url" do
        expect(@result).to(include(@source_url))
      end

      it "includes download_path" do
        expect(@result).to(include(@path))
      end

    end

  end

end
