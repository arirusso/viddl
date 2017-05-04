require "helper"

describe Viddl::Video::Instance do

  before(:each) do
    @video_id = "6g4dkBF5anU"
    @source_url = "https://youtube.com/watch?v=#{@video_id}"
    @video = Viddl::Video::Instance.new(@source_url)
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
